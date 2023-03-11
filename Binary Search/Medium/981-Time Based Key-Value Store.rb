# Approach
# Use hashmap for data structure.
# Use binary search when lastest_timestamp exceeds timestamp requested to find a lower timestamp.
class TimeMap
    def initialize()
        # Using hashmap as data structure. O(1) search time.
        @store={}
    end


=begin
    :type key: String
    :type value: String
    :type timestamp: Integer
    :rtype: Void
=end
    def set(key, value, timestamp)
        # If key present
        if @store[key]
            # Set timestamp value pair
            @store[key][timestamp] = value
            # If latest_timestamp available and our timestamp is larger than the current
            # latest_timestamp, we update the latest_timestamp value.
            if @store[key]["latest_timestamp"]
                if @store[key]["latest_timestamp"] < timestamp
                    @store[key]["latest_timestamp"] = timestamp
                end
            # If there is no latest_timestamp available set the timestamp.
            else
                @store[key]["latest_timestamp"] = timestamp
            end
        # If there is no key set, set the key, latest_timestamp and timestamp value pair.
        else
            @store[key] = {}
            @store[key]["latest_timestamp"] = timestamp
            @store[key][timestamp] = value

        end
    end


=begin
    :type key: String
    :type timestamp: Integer
    :rtype: String
=end
    def get(key, timestamp)
        # If key is available, based on the timestamp return the key value pair for the timestamp or check if anything with a lower timestamp is available. If there is no lower timestamp, return ""
        if @store[key]
            if @store[key][timestamp]
                return @store[key][timestamp]
            else
                if @store[key]["latest_timestamp"] > timestamp
                    # First value is latest_timestamp so we skip passed it when looking for
                    # lower value keys.
                    l_key = lower_key @store[key].keys[1..-1], timestamp
                    if l_key
                        return @store[key][l_key]
                    else
                        return ""
                    end

                else
                    return @store[key][@store[key]["latest_timestamp"]]
                end
            end
        # When there is no key available, return ""
        else
            return ""
        end
    end

    # Use binary search to find a lower timestamp key.
    def lower_key keys, timestamp
        low = 0
        high = keys.size - 1
        mid = (low + high)/2
        while true
            # Return nil if high goes negative.
            if high == -1
                return nil
            end
            # if keys[mid] is higher than timestamp lower the high value to get
            # lower values for the next comparison.
            if keys[mid] > timestamp
                high = high - 1
            # if keys[mid] is lower than timestamp, return keys mid.
            elsif keys[mid] < timestamp
                return keys[mid]
            end
            mid = (low + high)/2
        end
    end
end






# Your TimeMap object will be instantiated and called as such:
# obj = TimeMap.new()
# obj.set(key, value, timestamp)
# param_2 = obj.get(key, timestamp)
