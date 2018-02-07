class Solution(object):
    def moveZeroes(self, nums):
        """
        :type nums: List[int]
        :rtype: void Do not return anything, modify nums in-place instead.
        """
	times = nums.count(0) 
	for i in range(0, times):
		nums.remove(0) #if found 0, delete it
		nums.append(0) # append 0 at the end

# testing
s = Solution()
nums_1 = [1,0,2]
nums_2 = [0,1,2]
nums_3 = [1,2,0]
nums_4 = [1,2,3]
nums_5 = [1,2,0,3,0,4]
s.moveZeroes(nums_1)	 
s.moveZeroes(nums_2)	 
s.moveZeroes(nums_3)	 
s.moveZeroes(nums_4)	 
s.moveZeroes(nums_5)

print nums_1	 
print nums_2 
print nums_3	 
print nums_4	 
print nums_5	 
