#!/usr/bin/env julia

###############################################################################
#                                                                             #
# Copyright 2025-2026 Simon Brandt                                            #
#                                                                             #
# Licensed under the Apache License, Version 2.0 (the "License");             #
# you may not use this file except in compliance with the License.            #
# You may obtain a copy of the License at                                     #
#                                                                             #
#     http://www.apache.org/licenses/LICENSE-2.0                              #
#                                                                             #
# Unless required by applicable law or agreed to in writing, software         #
# distributed under the License is distributed on an "AS IS" BASIS,           #
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.    #
# See the License for the specific language governing permissions and         #
# limitations under the License.                                              #
#                                                                             #
###############################################################################

# Author: Simon Brandt
# E-Mail: simon.brandt@uni-greifswald.de
# Last Modification: 2026-10-30

using CSV: CSV
using DataStructures: OrderedDict
using StatsPlots: StatsPlots
using Tables: Tables

function get_code_length(file::String, parser::String)::Integer
    # Count the script's non-commented and non-blank lines.
    lines = readlines(file)
    code_length = 0
    count_commented_lines = false
    count_empty_lines = false
    for line in lines
        if parser == "docopts"
            # Set commented lines for counting within the help block,
            # which is necessary syntax for `docopts`.  The help block
            # starts with `"# Usage:"` and ends at the first uncommented
            # line.
            if line == "# Usage:"
                count_commented_lines = true
            elseif isempty(line)
                count_commented_lines = false
            end
        else
            # Set empty lines for counting within the help block, which
            # is necessary syntax for `getopt`, `getopts`, and shFlags.
            # The help block starts with `"Usage:"` (possibly with
            # leading whitespace) and ends at the line ending the
            # heredoc, a literal "EOF"
            if occursin(r"^\s*Usage:", line)
                count_empty_lines = true
            elseif line == "EOF"
                count_empty_lines = false
            end
        end

        if line == "# Possibly, exit prematurely."
            # Don't count lines not belonging to the actual command-line
            # parsing.
            break
        elseif occursin(r"^\s*$", line) && !count_empty_lines
            # Don't count empty lines, which only contain whitespace.
            continue
        elseif !occursin(r"^\s*#", line) || count_commented_lines
            # Count non-commented lines, and those where
            # `count_commented_lines` is `true`.
            code_length += 1
        end
    end

    return code_length
end

function plot_code_lengths(
    plot_file::String,
    code_lengths::OrderedDict{String, Integer},
    backend::Function,
)::Nothing
    # Create an empty bar plot to fill it later with the data series.
    backend()
    plot_attrs=(
        legend=false,
        xlabel="Command-line parser",
        ylabel="Code length (absolute)",
        margin=(36, :px),
        ydraw_arrow=true,
    )
    if backend == StatsPlots.pgfplotsx
        plot_attrs = (
            ;
            plot_attrs...,
            size=(883, 704),  # Empirical size for US letter, 2.5 cm margins.
            guidefont=StatsPlots.font(family="Times Roman", pointsize=20),
            tickfont=StatsPlots.font(family="Times Roman", pointsize=20),
            tex_output_standalone = true,
        )
    else
        plot_attrs = (
            ;
            plot_attrs...,
            size=(1600, 900),
            guidefontsize=18,
            tickfontsize=18,
        )
    end

    plot = StatsPlots.bar(; plot_attrs...)

    # For each script, plot the absolute code length in the bar plot.
    # Use an equally distributed set of colors from the `:viridis`
    # palette.
    parsers = keys(code_lengths)
    palette = StatsPlots.palette(:viridis, length(parsers))
    for (i, parser) in enumerate(parsers)
        StatsPlots.bar!(
            plot,
            [parser],
            [code_lengths[parser]],
            color=palette[i],
        )
    end

    # Overlay the y axis for the code lengths relative to the Shell
    # Argparser's code length.  Since the bars would look identical
    # (their values are divided by the same number), it is not necessary
    # to plot them.  Instead, plot an invisible bar whose value is the
    # maximum of all code lengths, guaranteeing that both y axes would
    # show all bars with the same height (which is calculated based on
    # the largest value).
    StatsPlots.bar!(
        StatsPlots.twinx(),
        [0.5],
        [maximum(values(code_lengths)) / code_lengths["Shell Argparser"]];
        plot_attrs...,
        xlabel="",
        ylabel="Code length (relative)",
        seriescolor=false,
        linecolor=false,
    )

    StatsPlots.savefig(plot, plot_file)

    if backend == StatsPlots.pgfplotsx
        # Replace `axis y line` by its starred version and add the
        # `-stealth` option to `y axis line style` to fix the Plots.jl
        # bug #5166, https://github.com/JuliaPlots/Plots.jl/issues/5166.
        # Further, add borders (margins) to the `\documentclass` and add
        # the `times` package for the Times Roman font.
        lines = readlines(plot_file, keep=true)
        for i in eachindex(lines)
            lines[i] = replace(
                lines[i],
                "axis y line" => "axis y line*",
                r"y axis line style=(?:\{)+" => s"\0-stealth, ",
                "\\documentclass[tikz]{standalone}"
                    => """\\documentclass[tikz=true, border=2.5cm]{standalone}
                        \\usepackage{times}""",
            )
        end
        write(plot_file, join(lines))
    end

    return nothing
end

function write_code_lengths(
    csv_file::String,
    code_lengths::OrderedDict{String, Integer},
)::Nothing
    # Save the absolute and relative code lengths as CSV file.
    header = ("Parser", "Code length (absolute)", "Code length (relative)")
    lines = []
    for (parser, code_length) in code_lengths
        line = hcat(
            parser,
            code_length,
            round(code_length / code_lengths["Shell Argparser"], digits=1),
        )
        lines = isempty(lines) ? line : vcat(lines, line)
    end

    CSV.write(csv_file, Tables.table(lines; header))

    return nothing
end

function main()::Nothing
    # Set the script names.
    directory = joinpath(@__DIR__, "cli_example_medium")
    parsers = OrderedDict{String, String}(
        "getopts"         => joinpath(directory, "test_getopts.sh"  ),
        "getopt"          => joinpath(directory, "test_getopt.sh"   ),
        "shFlags"         => joinpath(directory, "test_shflags.sh"  ),
        "docopts"         => joinpath(directory, "test_docopts.sh"  ),
        "Shell Argparser" => joinpath(directory, "test_argparser.sh"),
    )

    # Compute the code lengths for the parser scripts for comparison.
    code_lengths = OrderedDict{String, Integer}(
        parser => get_code_length(file, parser) for (parser, file) in parsers
    )

    # Plot the code lengths and save the plot as SVG and LaTeX file.
    # Additionally, create a CSV file with the data.
    directory = joinpath(@__DIR__, "code_length_comparison")
    plot_file_svg = joinpath(directory, "code_lengths.svg")
    plot_file_tex = joinpath(directory, "code_lengths.tex")

    plot_code_lengths(plot_file_svg, code_lengths, StatsPlots.gr)
    plot_code_lengths(plot_file_tex, code_lengths, StatsPlots.pgfplotsx)

    csv_file = joinpath(directory, "code_lengths.csv")
    write_code_lengths(csv_file, code_lengths)

    return nothing
end

main()
