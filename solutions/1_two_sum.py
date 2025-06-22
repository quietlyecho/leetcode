#
# Question: https://leetcode.com/problems/two-sum/
#

from typing import List, Optional

# method 1, brute force
class Solution_1:
    def twoSum(self, nums: List[int], target: int) -> Optional[List[int]]:
        for i in range(0, len(nums)):
            remain = target - nums[i]
            for j in range(i+1, len(nums)):
                if nums[j] == remain:
                    return([i, j])

# method 2, use two-pass hash table 
# the hash table is used to store values and their indices
class Solution_2:
    def twoSum(self, nums: List[int], target: int) -> Optional[List[int]]:
        if len(nums) <= 1:
            raise ValueError("Invalid nums input")

        d = {}

        for i in range(len(nums)):
            d[nums[i]] = i

        for j in range(len(nums)):
            complement = target - nums[j]
            if complement in d and d[complement] != j:
                return([j, d[complement]])

# method 3, use one-pass hash table
class Solution_3:
    def twoSum(self, nums: List[int], target: int) -> Optional[List[int]]:
        if len(nums) <= 1:
           raise ValueError("Invalid nums input")

        d = {}

        for i in range(len(nums)):
            if target - nums[i] in d:
                return [d[target - nums[i]], i]
            else:
                d[nums[i]] = i
