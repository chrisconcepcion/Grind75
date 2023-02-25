# Approach
# 1. Go through prerequisites array and convert it to a hash where course is key and prerequistes are a set of values
# 2. Go through all the courses using hash.keys to get the courses and determine if we can complete them all by checking if we can completed prerequisites first using DFS. Keep track of all completed courses in a set.
# 3. Check if completed courses equate to number of courses to determine.

# DFS
# Time: O(|Edges| + |Vertices|)
# Space: O(|Matched edges| * |Bonus Edges(edges unused but stored)|)

# @param {Integer} num_courses
# @param {Integer[][]} prerequisites
# @return {Boolean}
def can_finish(num_courses, prerequisites)

    prerequisites_hash = {}
    completed_courses = Set.new
    all_courses = Set.new
    prerequisites.each do |pre|
        all_courses
        course = pre[0]
        prereq = pre[1]
        all_courses << course
        all_courses << prereq
        if !prerequisites_hash[course]
            prerequisites_hash[course] = Set.new([prereq])
        else
             prerequisites_hash[course] << prereq
        end
    end
    # If there are no courses then they are all complete-able.
    if all_courses.size == 0
        return true
    end

    # Keep track of the difference between courses with prerequistes and number of courses.
    # We will use this value later to determine if we were able to complete all courses.
    missing_count = num_courses - all_courses.size

    # Go through each course.
    all_courses.each do |course|
        completed_courses = qualify_course_and_update_completed_courses course, prerequisites_hash, completed_courses
        if completed_courses == false
            return completed_courses
        end
    end

    # If completed courses and missing completed courses equate to number of courses, return true.
    if (completed_courses.size + missing_count) == num_courses
        return true
    else
        return false
    end
end

# Return array containing all completed course if course can be completed.
# Otherwise return false.

# DFS
# Time: O(|Edges| + |Vertices|)
# Space: O(|Matched edges| * |Bonus Edges(edges unused but stored)|)
def qualify_course_and_update_completed_courses course, prerequisites, completed_courses, stack_too_deep_preventer = Set.new
    # check if course is completed
    if !completed_courses.include? course
        # can we complete prereq? or if there is no preeq
        prereq = prerequisites[course]


        # Prevent circular prerequistes from causing infinite loop.
        if stack_too_deep_preventer.include?(course.to_s + ":"+prereq.to_s)
            return false
        else
            stack_too_deep_preventer << course.to_s + ":"+prereq.to_s
        end

        # If there are no prerequisties or prerequistes already completed add course to
        # completed courses.
        if prereq == nil || (prereq - completed_courses).size == 0
            completed_courses << course
        else
            # Otherwise go through each prerequiste and determine if the prerequiste can be completed.
            prereq.each do |pre|
                completed_courses = qualify_course_and_update_completed_courses pre, prerequisites, completed_courses, stack_too_deep_preventer
                if completed_courses == false
                    return false
                end
            end

            # if rerequistes are completed add course to completed courses.
            if (prereq - completed_courses).size == 0
                completed_courses << course
            end
        end
    end
    completed_courses
end
