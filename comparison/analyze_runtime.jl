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
# Last Modification: 2025-07-24

using CSV: CSV
using Dates: Dates
using Statistics: Statistics
using StatsPlots: StatsPlots
using Tables: Tables

function get_commands()::Dict{String, Cmd}
    # Set the scripts and their common command-line arguments.
    scripts = (
        "argparser_wrapper.sh",
        "docopts_wrapper.sh",
        "getopt_wrapper.sh",
        "getopts_wrapper.sh",
        "shflags_wrapper.sh",
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
    commands = Dict()
    for script in scripts
        script_name = script
        if basename(pwd()) != "comparison"
            script = "comparison/$script"
        end

        commands[script_name] = `bash $script $args`
    end

    return commands
end

function get_runtimes(command::Cmd)::Dict{String, Integer}
    # Run the command 1000 times and return the runtimes.
    runtimes = Dict()
    for i in 1:1000
        start_time = Dates.datetime2epochms(Dates.now())
        run(pipeline(command, stdout=devnull))
        end_time = Dates.datetime2epochms(Dates.now())
        runtimes["Runtime $i"] = end_time - start_time
    end

    return runtimes
end

function compute_runtime_stats(
    runtimes::Dict{String, Integer}
)::Dict{String, Number}
    # Compute the mean, standard deviation, and median for the runtimes.
    stats = Dict(
        "Mean" => Statistics.mean(values(runtimes)),
        "Std dev" => Statistics.std(values(runtimes)),
        "Median" => Statistics.median(values(runtimes)),
    )

    return stats
end

function plot_runtime_stats(
    plot_file::String,
    runtimes::Dict{String, Dict{String, Integer}},
)::Nothing
    # Create an empty violin plot to fill it later with the data series.
    plot = StatsPlots.violin(
        size=(1600, 900),
        legend=false,
        xlabel="Command-line parser",
        ylabel="Runtime [ms]",
        labelfontsize=18,
        tickfontsize=18,
        margin=(36, :px),
    )

    # For each script, extract the runtimes from the dictionary and plot
    # them together as violin plot.  Use an equally distributed set of
    # colors from the `:viridis` palette.
    script_names = sort(collect(keys(runtimes)))
    palette = StatsPlots.palette(:viridis, length(script_names))
    for (i, script_name) in enumerate(script_names)
        label = chopsuffix(script_name, "_wrapper.sh")
        StatsPlots.violin!(
            plot,
            repeat([label], length(runtimes[script_name])),
            collect(values(runtimes[script_name])),
            color=palette[i],
        )
    end

    StatsPlots.savefig(plot, plot_file)

    return nothing
end

function write_runtime_stats(
    csv_file::String,
    stats::Dict{String, Dict{String, Number}},
)::Nothing
    # Save the the mean, standard deviation, and median for the runtimes
    # as CSV file.
    header = ("Script", "Mean", "Std dev", "Median")
    lines = nothing
    for script_name in sort(collect(keys(stats)))
        line = Union{String, Number}[script_name]
        for stat in ("Mean", "Std dev", "Median")
            push!(line, round(stats[script_name][stat], digits=1))
        end

        if isnothing(lines)
            lines = permutedims(line)
        else
            lines = vcat(lines, permutedims(line))
        end
    end

    CSV.write(csv_file, Tables.table(lines; header))

    return nothing
end

function main()::Nothing
    # Compute the runtimes for the scripts for comparison.
    runtimes = Dict{String, Dict{String, Integer}}()
    stats = Dict{String, Dict{String, Number}}()

    commands = get_commands()
    for (script_name, command) in pairs(commands)
        runtimes[script_name] = get_runtimes(command)
        stats[script_name] = compute_runtime_stats(runtimes[script_name])
    end

    # Plot the runtimes and save the plot as SVG file.  Additionally,
    # create a CSV file with the runtime stats.
    csv_file = "stats.csv"
    plot_file = "stats.svg"
    if basename(pwd()) != "comparison"
        csv_file = "comparison/$csv_file"
        plot_file = "comparison/$plot_file"
    end

    plot_runtime_stats(plot_file, runtimes)
    write_runtime_stats(csv_file, stats)

    return nothing
end

main()
