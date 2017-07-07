import glob

def getTimes(project):
    # Get all log files for project
    files = glob.glob(project + "-*")
    sortedFiles = sorted(files)
    # Set empty array for results
    results = []

    # Moronic way for me to get total core count of test computer
    testCores = sortedFiles[-1].split(project + "-")[1].split("-")[0]

    # Add arrays to results according to number of cores
    for core in range(int(testCores)):
        results.append([])

    # Record results into the results array
    for filename in sortedFiles:
        cores = filename.split(project + "-")[1].split("-")[0]
        with open(filename) as f:
            for line in f.readlines():
                if line.startswith("real\t"):
                    time = line.split("real\t")[1].strip()
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