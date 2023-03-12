# Failing approach, too slow. Fails at 15/30 test case.
# Approach
# We need to return the maximum amount that can be made.
# Go through each possibility and return the the combination of possibilities where we create the most profit.
# We can try to coming up with a sorted array by somehow combining values from start time and end time.
startTime = [1,2,3,4,6],
endTime = [3,5,10,6,9]
profit = [20,20,100,70,60]


combinedTime = [1,2.9,3, 9,9]
combinedProfit = [20,100]


# @param {Integer[]} start_time
# @param {Integer[]} end_time
# @param {Integer[]} profit
# @return {Integer}
def job_scheduling(start_time, end_time, profit)

    index = 0
    max_index = start_time.size - 1
    max_profit = 0

    index = 0
    job_data = []
    last_job_index = start_time.size
    while index < last_job_index
        job_data << [start_time[index], end_time[index], profit[index]]
        index = index + 1
    end

    job_data.sort!{|a, b| a[0] <=> b[0]}
    start_time = job_data.collect{|a| a[0]}
    max_profit_calc = MaxProfit.new(start_time, job_data)
    index = 0
    while index < max_index
         max_profit_calc.maximum_profit_from_starting_time job_data[index]
         index = index + 1
    end

    max_profit_calc.max_profit
end

class MaxProfit
    attr_accessor :max_profit
    def initialize(start_time, job_data)
        @start_time = (start_time)
        @job_data = job_data
        @last_job_index = @start_time.size - 1
        @max_profit = 0
    end

    # We are gathering a list of job indexes recursively based on start and end times
    # Then we will do the profit calculation on each combination and return the profit.
    def maximum_profit_from_starting_time job_data
        current_profit = (gather_job_possibilities_based_on_first_job job_data)
        if current_profit > @max_profit
            @max_profit = current_profit
        end
    end

    def gather_job_possibilities_based_on_first_job job_data, end_time = 0, current_val = 0
        possibilities = []
        # Get the first job profit
        # Update end time
        start_time = job_data[0]

        end_time = job_data[1] - 0.1

        current_val = current_val + job_data[2]


        # Then get remaining available jobs after completing the job.
        next_jobs_start_index = available_jobs_start_index(end_time)
        jobs_indexes = []

        if next_jobs_start_index
            jobs_indexes = (next_jobs_start_index..@last_job_index)
        end

        #return jobs_indexes
        current_possibility = current_val
        current_max_profit = current_val
        if jobs_indexes.size > 0

            jobs_indexes.each do |job_index|
                 job_index_results = (gather_job_possibilities_based_on_first_job @job_data[job_index], end_time, current_val)

                if current_max_profit < job_index_results
                    current_max_profit = job_index_results
                end

            end
            return current_max_profit
        else
            return current_possibility
        end
    end


    # Returns a list of start time indexes that are greater than end_time
    def available_jobs_start_index end_time
        # Return the index of the first job where end_time > start_time

        #next_job_index = @memod_start_time[index].bsearch_index{|t| t > end_time }
        next_job_index = @start_time.bsearch_index{|t| t > end_time }

        if next_job_index
            return next_job_index
        else
            return nil
        end
    end


end
