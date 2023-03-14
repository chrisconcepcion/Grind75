# Beats 100% runtime, 25% memory.
# Approach
# 1. Create array containing start_time, end_time and profit into one array, lets call it jobs_data.
# 2. Sort jobs_data by start_time and reverse jobs_data. Important to reverse the array as we need to memo all the calculations and determine the highest profit so we can reuse it later.
# 3. Sort start_time array.
# 4. Transverse the jobs_data array and when we need to find the jobs that are still available based on start time, get the highest profit job and add it to the current job profit then memo the total profit using the index of the job as the memo key. Make sure to store the maximum profit if it exceeds the previous maximum profit value.
# 5. Return maximum profit when we are all down tranversing the jobs_data array.

# @param {Integer[]} start_time
# @param {Integer[]} end_time
# @param {Integer[]} profit
# @return {Integer}
# Time Complexity: O(n log n) due to using quicksort to sort arrays.
# Space Complexity: O(n) creating a few arrays and a hash.
def job_scheduling(start_time, end_time, profit)

    # Collect all job data from start_time, end_time and profit into one array.
    index = 0
    jobs_size = start_time.size
    jobs_data = []
    while index < jobs_size
        jobs_data << [start_time[index], end_time[index], profit[index]]
        index = index + 1
    end

    # Sort job data by start time and then reverse the array.
    # Time Complexity: O(n log n)
    # Space Complexity: O(log n)
    jobs_data.sort_by!{|job| job[0]}.reverse!

    # Sort start time.
    # Time Complexity: O(n log n)
    # Space Complexity: O(log n)
    start_time = start_time.sort!

    # Traverse the job data array going through each job in reverse order.
    # Calculate job_sorted_by_start_time_index(index if we sorted by start time, remember the array is currently reversed).
    @max_profit = 0
    @memo = {}
    index = 0
    job_sorted_by_start_time_index = jobs_size - 1
    while index < jobs_size
        # Set job data based on index.
        job_data = jobs_data[index]
        # Update end time

        # Set job time.
        job_end_time = job_data[1]

        # Profit for job
        job_profit = job_data[2]

        # Combine current job profit with the accumulated value of
        # jobs available(based on end time) after completing the current job.
        job_profit = job_profit + next_job_profit(job_end_time, start_time, @memo)

        # Set @max_profit if current job profit is larger than the current @max_profit.
        if job_profit > @max_profit
            @max_profit = job_profit
        end

        # Memo the job profit.
        # We set max profit here despite there being multiple possibilities
        # for available jobs.
        # This is because only the maximum profit is the only profit we are interest in and we save on runtime if we do not check all possibilities.
        @memo[job_sorted_by_start_time_index] = @max_profit

        # Update index and job_sorted_by_start_time_index
        index = index + 1
        job_sorted_by_start_time_index = job_sorted_by_start_time_index - 1
    end

    @max_profit
end

# Returns the profit from the next job proceeding end_time(if available).
# Time Complexity: O(log n)
# Space Complexity: O(log n)
def next_job_profit end_time, start_time, memo
    # Use binary search to find the next job start time index.
    next_job_index = start_time.bsearch_index{|t| t >= end_time }

    # If we find a next job index, return the profit contained within our memo.
    if next_job_index
        return memo[next_job_index]
    else
        return 0
    end
end
