# Definition for a binary tree node.
class TreeNode(object):
    def __init__(self, x):
        self.val = x
        self.left = None
        self.right = None

class Solution(object):
    def sortedArrayToBST(self, nums):
        """
        :type nums: List[int]
        :rtype: TreeNode
        """
        # exception value case
        if nums is None or len(nums) == 0:
            return None
        
        # get root; root has to exist when nums is not None (i.e., at least 1 element)
        # todo: why using the middel index as root can ensure hegith balance?
        mid = (len(nums) - 1) / 2
        root = TreeNode(nums[mid])
        
        # get left/right bst
        root.left = self.sortedArrayToBST(nums[:mid])
        root.right = self.sortedArrayToBST(nums[mid+1:])
        
        return root
