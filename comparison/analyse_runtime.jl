#!/usr/bin/env julia

# Author: Simon Brandt
# E-Mail: simon.brandt@uni-greifswald.de
# Last Modification: 2025-06-17

using Dates: Dates
using Statistics: Statistics
using StatsPlots: StatsPlots

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
    # Run the command 100 times and return the runtimes.
    runtimes = Dict()
    for i in 1:100
        start_time = Dates.datetime2epochms(Dates.now())
        run(pipeline(command, stdout=devnull))
        end_time = Dates.datetime2epochms(Dates.now())
        runtimes["Runtime $i"] = end_time - start_time
    end

    return runtimes
end

function compute_runtime_stats(
    runtimes::Dict{String, Integer}
)::Dict{String, Any}
    # Compute the mean, standard deviation, and median for the runtimes.
    stats = Dict(
        "Mean" => Statistics.mean(values(runtimes)),
        "Std dev" => Statistics.std(values(runtimes)),
        "Median" => Statistics.median(values(runtimes)),
    )

    return stats
end

function plot_runtime_stats(
    runtimes::Dict{String, Dict{String, Integer}},
)::StatsPlots.Plot
    # Create an empty violin plot to fill it later with the data series.
    plot = StatsPlots.violin(
        size=(1600, 900),
        legend=false,
        tickfontsize=18,
    )

    # For each script, extract the runtimes from the dictionary and plot
    # them together as violin plot.  Use an equally distributed set of
    # colors from the `:viridis` palette.
    script_names = sort(collect(keys(runtimes)))
    palette = StatsPlots.get_color_palette(:viridis, 3)
    for (i, script_name) in enumerate(script_names)
        label = chopsuffix(script_name, "_wrapper.sh")
        StatsPlots.violin!(
            plot,
            repeat([label], length(runtimes[script_name])),
            collect(values(runtimes[script_name])),
            color=palette[length(palette) ÷ length(script_names) * i],
        )
    end

    return plot
end

function main()::Nothing
    # Compute the runtimes for the scripts for comparison.
    runtimes = Dict()
    stats = Dict()

    commands = get_commands()
    for (script_name, command) in pairs(commands)
        runtimes[script_name] = get_runtimes(command)
        stats[script_name] = compute_runtime_stats(runtimes[script_name])
    end

    # Plot the runtimes and save the plot as SVG file.
    plot = plot_runtime_stats(runtimes)

    plot_file = "stats.svg"
    if basename(pwd()) != "comparison"
        plot_file = "comparison/$plot_file"
    end
    StatsPlots.savefig(plot, plot_file)

    return nothing
end

main()
