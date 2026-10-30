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
using Dates: Dates
using Statistics: Statistics
using StatsPlots: StatsPlots
using Tables: Tables

function set_commands()::OrderedDict{String, Cmd}
    # Set the scripts and their shared command-line arguments.
    directory = joinpath(@__DIR__, "cli_example_medium")
    parsers = OrderedDict{String, String}(
        "getopts"         => joinpath(directory, "test_getopts.sh"  ),
        "getopt"          => joinpath(directory, "test_getopt.sh"   ),
        "shFlags"         => joinpath(directory, "test_shflags.sh"  ),
        "docopts"         => joinpath(directory, "test_docopts.sh"  ),
        "Shell Argparser" => joinpath(directory, "test_argparser.sh"),
    )

    args=(
        "-v",
        "-e",
        "-a",
        "2",
        "-n",
        "A. R. G. Parser",
        "-r",
        "b",
        "--",
        "template.html",
        "argparser.html",
    )

    # Set the command as `Cmd` object.
    commands = OrderedDict{String, Cmd}(
        parser => `bash $file $args` for (parser, file) in parsers
    )

    return commands
end

function get_runtimes(command::Cmd)::Vector{Integer}
    # Run the command 5000 times and return the runtimes.
    runtimes = Vector{Integer}()
    sizehint!(runtimes, 5000)

    for _ in 1:5000
        start_time = Dates.datetime2epochms(Dates.now())
        run(pipeline(command, stdout=devnull))
        end_time = Dates.datetime2epochms(Dates.now())
        push!(runtimes, end_time - start_time)
    end

    return runtimes
end

function compute_runtime_stats(
    runtimes::Vector{Integer}
)::OrderedDict{String, Number}
    # Compute the mean, standard deviation, and median for the runtimes.
    stats = OrderedDict(
        "Mean"    => Statistics.mean(runtimes),
        "Std dev" => Statistics.std(runtimes),
        "Median"  => Statistics.median(runtimes),
    )

    return stats
end

function plot_runtime_stats(
    plot_file::String,
    runtimes::OrderedDict{String, Vector{Integer}},
    backend::Function,
)::Nothing
    # Create an empty violin plot to fill it later with the data series.
    backend()
    plot_attrs=(
        legend=false,
        xlabel="Command-line parser",
        ylabel="Runtime [ms]",
        margin=(36, :px),
        ydraw_arrow=true,
    )
    if backend == StatsPlots.pgfplotsx
        plot_attrs = (
            ;
            plot_attrs...,
            size=(915, 704),  # Empirical size for US letter, 2.5 cm margins.
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

    plot = StatsPlots.violin(; plot_attrs...)

    # For each script, extract the runtimes from the dictionary and plot
    # them together as violin plot.  Use an equally distributed set of
    # colors from the `:viridis` palette.
    parsers = keys(runtimes)
    palette = StatsPlots.palette(:viridis, length(parsers))
    for (i, parser) in enumerate(parsers)
        StatsPlots.violin!(
            plot,
            repeat([parser], length(runtimes[parser])),
            runtimes[parser],
            color=palette[i],
        )
    end

    StatsPlots.savefig(plot, plot_file)

    if backend == StatsPlots.pgfplotsx
        # Add borders (margins) to the `\documentclass` and add the
        # `times` package for the Times Roman font.
        lines = readlines(plot_file, keep=true)
        for i in eachindex(lines)
            lines[i] = replace(
                lines[i],
                "\\documentclass[tikz]{standalone}"
                    => """\\documentclass[tikz=true, border=2.5cm]{standalone}
                        \\usepackage{times}""",
            )
        end
        write(plot_file, join(lines))
    end

    return nothing
end

function write_runtime_stats(
    csv_file::String,
    stats::OrderedDict{String, OrderedDict{String, Number}},
)::Nothing
    # Save the mean, standard deviation, and median for the runtimes as
    # CSV file.
    header = ("Parser", "Mean", "Std dev", "Median")
    lines = []
    for (parser, parser_stats) in stats
        line = hcat(
            parser,
            round(parser_stats["Mean"], digits=1),
            round(parser_stats["Std dev"], digits=1),
            round(parser_stats["Median"], digits=1),
        )
        lines = isempty(lines) ? line : vcat(lines, line)
    end

    CSV.write(csv_file, Tables.table(lines; header))

    return nothing
end

function write_runtimes(
    csv_file::String,
    runtimes::OrderedDict{String, Vector{Integer}},
)::Nothing
    # Save the actual runtimes as CSV file.
    parsers = keys(runtimes)
    cols = hcat((runtimes[parser] for parser in parsers)...)
    CSV.write(csv_file, Tables.table(cols; header=Tuple(parsers)))

    return nothing
end

function main()::Nothing
    # Compute the runtimes for the scripts for comparison.
    runtimes = OrderedDict{String, Vector{Integer}}()
    stats = OrderedDict{String, OrderedDict{String, Number}}()

    commands = set_commands()
    for (parser, command) in pairs(commands)
        runtimes[parser] = get_runtimes(command)
        stats[parser] = compute_runtime_stats(runtimes[parser])
    end

    # Plot the runtimes and save the plot as SVG and LaTeX file.
    # Additionally, create a CSV file with the runtimes and runtime
    # stats.
    directory = joinpath(@__DIR__, "runtime_comparison")
    plot_file_svg = joinpath(directory, "runtime_stats.svg")
    plot_file_tex = joinpath(directory, "runtime_stats.tex")

    plot_runtime_stats(plot_file_svg, runtimes, StatsPlots.gr)
    plot_runtime_stats(plot_file_tex, runtimes, StatsPlots.pgfplotsx)

    csv_file = joinpath(directory, "runtimes.csv")
    stats_file = joinpath(directory, "runtime_stats.csv")

    write_runtimes(csv_file, runtimes)
    write_runtime_stats(stats_file, stats)

    return nothing
end

main()
