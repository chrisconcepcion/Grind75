# Approach
# 1. Gather all accounts into a hash where the hash key is the first name.
# 2. As we add all accounts into our hash, we splice together accounts where emails intersect.

# Time: O(|Vertices|)
# Space: O(|Vertices|)

# @param {String[][]} accounts
# @return {String[][]}
def accounts_merge(accounts)
    # array of arrays
    # each array first element is a name
    # following elements are emails

    # Rules:
    # If an element shares the first name and has at least one of the same emails,
    # the matching elements must be merged into a single array.

    # collect all accounts by name(Hashmap)
    accounts_hash = {}
    index = 0
    accounts_size = accounts.size
    keys = []
    return_array = []
    while index < accounts_size
        account = accounts[index]
        name = account[0]

        if accounts_hash[name]
            accounts_hash[name] = splice_accounts accounts_hash[name], account[1..-1]

        else
            keys << name
            accounts_hash[name] = [account[1..-1].uniq]
        end
        index = index + 1
    end

    # combine accounts with the same name with common emails
    index = 0
    keys
    keys_size = keys.size
    while index < keys_size
        key = keys[index]
        accounts_with_same_name = accounts_hash[key]
        if accounts_with_same_name.size > 1
            accounts_with_same_name.each do |account|
                return_array << (account.sort!.prepend(key))

            end
        else

            return_array << accounts_with_same_name[0].sort!.prepend(key).uniq
        end
        index = index + 1
    end

   return_array
end


# accounts_emails contains all emails which have the same first name, its an array of arrays where there are no matches emails between each of the arrays.
# user_email_array is another set of emails that have the same first name.
# What we are doing here is merging user_email_array into any of the arrays in accounts_emails where an email matches and throwing the merged array into another array called found_matches.
# Then we combine all the arrays in found_matches into one uniq array as they are all for the same account and we set the uniq array as the first element in a new blank array. Lately we add all accounts that didnt intersect into to accounts_emails.
# Time: O(|Vertices|)
# Space: O(|Vertices|)
 def splice_accounts accounts_emails, user_email_array
    found_matches = []
    not_found = []
    user_email_array.uniq!

    accounts_emails.each do |account_emails|
        found = (account_emails & user_email_array)
        if found.size > 0
            found_matches << (account_emails.concat user_email_array)
        else
            not_found << account_emails
        end
    end
    if found_matches.size > 0
        first_found = found_matches[0]
        found_matches[1..-1].each do |match|
            first_found.concat match
        end
        first_found.uniq!
        accounts_emails = [first_found]

        if not_found.size > 0
            accounts_emails.concat not_found
        end

    else
        accounts_emails << user_email_array
    end


    accounts_emails
end
