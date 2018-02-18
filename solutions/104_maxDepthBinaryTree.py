#!/usr/bin/env python2
# -*- coding: utf-8 -*-
"""
Created on Sat Feb 17 14:45:10 2018

@author: yabinwang
"""

# Definition for a binary tree node.
#class TreeNode(object):
#    def __init__(self, x):
#        self.val = x
#        self.left = None
#        self.right = None

class Solution(object):
    def maxDepth(self, root):
        """
        :type root: TreeNode
        :rtype: int
        """
        if root is None:
            return 0
        
        leftDepth = self.maxDepth(root.left)
        rightDepth = self.maxDepth(root.right)
        return max(leftDepth, rightDepth) + 1