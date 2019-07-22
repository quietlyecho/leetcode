#
# Question: https://leetcode.com/problems/two-sum/
#

# method 1, brute force
class Solution:
    def twoSum(self, nums: List[int], target: int) -> List[int]:
        for i in range(0, len(nums)):
            remain = target - nums[i]
            for j in range(i+1, len(nums)):
                if nums[j] == remain:
                    return([i, j])

# method 2, use two-pass hash table 
# the hash table is used to store values and their indices
class Solution:
    def twoSum(self, nums: List[int], target: int) -> List[int]:
        if len(nums) <= 1:
            return False

        d = {}

        for i in range(len(nums)):
            d[nums[i]] = i

        for j in range(len(nums)):
            complement = target - nums[j]
            if complement in d and d[complement] != j:
                return([j, d[complement]])

# method 3, use one-pass hash table
# [to do] still needs to enhance my understanding on this method
class Solution:
    def twoSum(self, nums: List[int], target: int) -> List[int]:
        if len(nums) <= 1:
            return False

        d = {}

        for i in range(len(nums)):
            if target - nums[i] in d:
                return [d[target - nums[i]], i]
            else:
                d[nums[i]] = i
