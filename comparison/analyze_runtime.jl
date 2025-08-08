#!/usr/bin/env julia

###############################################################################
#                                                                             #
# Copyright 2025 Simon Brandt                                                 #
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
# Last Modification: 2025-08-08

using CSV: CSV
using DataStructures: OrderedDict
using Dates: Dates
using Statistics: Statistics
using StatsPlots: StatsPlots
using Tables: Tables

function get_commands()::OrderedDict{String, Cmd}
    # Set the scripts and their common command-line arguments.
    scripts = OrderedDict{String, String}(
        "getopts" => "getopts_wrapper.sh",
        "getopt" => "getopt_wrapper.sh",
        "shFlags" => "shflags_wrapper.sh",
        "docopts" => "docopts_wrapper.sh",
        "Shell Argparser" => "argparser_wrapper.sh",
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

    # If not called from the "comparison" directory, but the base
    # directory, prepend the "comparison" directory to the script name.
    # Set the command as `Cmd` object.
    commands = OrderedDict()
    for (script_name, script) in scripts
        if basename(pwd()) != "comparison"
            scripts[script_name] = "comparison/$script"
        end

        commands[script_name] = `bash $(scripts[script_name]) $args`
    end

    return commands
end

function get_runtimes(command::Cmd)::OrderedDict{String, Integer}
    # Run the command 1000 times and return the runtimes.
    runtimes = OrderedDict()
    for i in 1:1000
        start_time = Dates.datetime2epochms(Dates.now())
        run(pipeline(command, stdout=devnull))
        end_time = Dates.datetime2epochms(Dates.now())
        runtimes["Runtime $i"] = end_time - start_time
    end

    return runtimes
end

function compute_runtime_stats(
    runtimes::OrderedDict{String, Integer}
)::OrderedDict{String, Number}
    # Compute the mean, standard deviation, and median for the runtimes.
    stats = OrderedDict(
        "Mean" => Statistics.mean(values(runtimes)),
        "Std dev" => Statistics.std(values(runtimes)),
        "Median" => Statistics.median(values(runtimes)),
    )

    return stats
end

function plot_runtime_stats(
    plot_file::String,
    runtimes::OrderedDict{String, OrderedDict{String, Integer}},
    backend::Function,
)::Nothing
    # Create an empty violin plot to fill it later with the data series.
    backend()
    plot_attrs=(
        size=(1600, 900),
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
            guidefont=StatsPlots.font(family="Times Roman", pointsize=24),
            tickfont=StatsPlots.font(family="Times Roman", pointsize=24),
            tex_output_standalone = true,
        )
    else
        plot_attrs = (
            ;
            plot_attrs...,
            guidefontsize=18,
            tickfontsize=18,
        )
    end

    plot = StatsPlots.violin(; plot_attrs...)

    # For each script, extract the runtimes from the dictionary and plot
    # them together as violin plot.  Use an equally distributed set of
    # colors from the `:viridis` palette.
    script_names = keys(runtimes)
    palette = StatsPlots.palette(:viridis, length(script_names))
    for (i, script_name) in enumerate(script_names)
        StatsPlots.violin!(
            plot,
            repeat([script_name], length(runtimes[script_name])),
            collect(values(runtimes[script_name])),
            color=palette[i],
        )
    end

    StatsPlots.savefig(plot, plot_file)

    return nothing
end

function write_runtime_stats(
    csv_file::String,
    stats::OrderedDict{String, OrderedDict{String, Number}},
)::Nothing
    # Save the mean, standard deviation, and median for the runtimes as
    # CSV file.
    header = ("Script", "Mean", "Std dev", "Median")
    lines = []
    for script_name in keys(stats)
        line = hcat(
            script_name,
            round(stats[script_name]["Mean"], digits=1),
            round(stats[script_name]["Std dev"], digits=1),
            round(stats[script_name]["Median"], digits=1),
        )

        if isempty(lines)
            lines = line
        else
            lines = vcat(lines, line)
        end
    end

    CSV.write(csv_file, Tables.table(lines; header))

    return nothing
end

function write_runtimes(
    csv_file::String,
    runtimes::OrderedDict{String, OrderedDict{String, Integer}},
)::Nothing
    # Save the actual runtimes as CSV file.
    script_names = keys(runtimes)
    header = ("Run ID", script_names...)
    cols = collect(keys(runtimes["Shell Argparser"]))

    for script_name in script_names
        col = collect(values(runtimes[script_name]))
        cols = hcat(cols, col)
    end

    CSV.write(csv_file, Tables.table(cols; header))

    return nothing
end

function main()::Nothing
    # Compute the runtimes for the scripts for comparison.
    runtimes = OrderedDict{String, OrderedDict{String, Integer}}()
    stats = OrderedDict{String, OrderedDict{String, Number}}()

    commands = get_commands()
    for (script_name, command) in pairs(commands)
        runtimes[script_name] = get_runtimes(command)
        stats[script_name] = compute_runtime_stats(runtimes[script_name])
    end

    # Plot the runtimes and save the plot as SVG and LaTeX file.
    # Additionally, create a CSV file with the runtimes and runtime
    # stats.
    csv_file = "runtimes.csv"
    stats_file = "stats.csv"
    plot_file = "stats.svg"
    if basename(pwd()) != "comparison"
        csv_file = "comparison/$csv_file"
        stats_file = "comparison/$stats_file"
        plot_file = "comparison/$plot_file"
    end

    plot_runtime_stats(plot_file, runtimes, StatsPlots.gr)

    plot_file = replace(plot_file, ".svg" => ".tex")
    plot_runtime_stats(plot_file, runtimes, StatsPlots.pgfplotsx)

    write_runtimes(csv_file, runtimes)
    write_runtime_stats(stats_file, stats)

    return nothing
end

main()
