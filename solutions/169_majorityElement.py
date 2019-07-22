class Solution(object):
    def majorityElement(self, nums):
        """
        :type nums: List[int]
        :rtype: int
        """
        nums.sort()
        target_index = (len(nums) / 2 + 1) - 1
        return nums[target_index]