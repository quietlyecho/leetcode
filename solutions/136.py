class Solution(object):
    def singleNumber(self, nums):
        """
        :type nums: List[int]
        :rtype: int
        """
	# get distinct values of a list into a set
	nums_set = set(nums)
	nums_uniq = list(nums_set)
	# count all unique values against the list
	result = sum(nums_uniq) * 2 - sum(nums)
	return( result )

sol = Solution()
print sol.singleNumber([1,1,2,2,3,3,4,4,5])
