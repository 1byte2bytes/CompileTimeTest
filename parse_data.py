from glob import glob

def getTimes(project):
    # Get all log files for project
    files = glob(project + "-*")
    sortedFiles = sorted(files)
    # Set empty variables for later use
    results = []
    testCores = 0

    # Get the number of cores in test computer
    with open("cores.log") as f:
        testCores = int(f.readline())

    # Add lists to results according to number of cores
    for core in range(int(testCores)):
        results.append([])

    # Record results into the results lists
    for filename in sortedFiles:
        cores = filename.split(project + "-")[1].split("-")[0]

        with open(filename) as f:
            for line in f.readlines():
                # Check if line starts with "real   ", this is what the "time" command outputs
                if line.startswith("real\t"):
                    # Split the line to get the number
                    time = line.split("real\t")[1].strip()
                    # Record that to the list in results for the current core count
                    results[int(cores)-1].append(time)

    # Output results to a CSV
    with open("results-" + project + ".csv", "w") as f:
        for row in results:
            print(row)
            f.write(','.join(['"'+i+'"' for i in row]))
            f.write('\n')

getTimes("busybox")
getTimes("linux")
getTimes("coreutils")