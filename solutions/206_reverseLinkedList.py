#!/usr/bin/env python2
# -*- coding: utf-8 -*-
"""
Created on Sat Feb 24 16:25:08 2018

@author: yabinwang
"""
# Definition for singly-linked list.
class ListNode(object):
    def __init__(self, x):
        self.val = x
        self.next = None

class List(object):
    def _init_(self, head):
        self.head = head
    
    def find_last(self):
        current = self.head
        while current.next is not None:
            current = current.next
        return current
    
    def add_node(self, node):
        last = self.find_last()
        last.next = node

node3 = ListNode(3)
node2 = ListNode(2)      
node1 = ListNode(1)
list1 = List(node1)
list1.add_node(node2)
list1.add_node(node3)

class Solution(object):
    def reverseList(self, head):
        """
        :type head: ListNode
        :rtype: ListNode
        """
        current = head
        while current.next is not None:
                current = current.next
        last = current # get last node
        
        while head.next is not None:       
            current = head
            while current.next.next is not None:
                current = current.next

            current.next.next = current # so that next node is linking back to current node
            current.next = None # remove the link from current to next
        return last