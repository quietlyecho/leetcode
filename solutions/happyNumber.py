class Solution(object):
    def isHappy(self, n):
        """
        :type n: int
        :rtype: bool
        """
        # use Floyd's Tortoise and Hare algorithm to detect cycle
        # below method is based on this math fact:
        # there are only 2 scenarios:
        # happy:    n_1,n_2,n_3,...n_m,1,1,1....
        # unhappy:  n_1,n_2,n_3,...,n_k,n_1,n_2,...,n_k,n_1,n_2,....         
        slow = fast = n
        slow = self.get_sum_digit_sqr(slow)
        fast = self.get_sum_digit_sqr(fast)
        fast = self.get_sum_digit_sqr(fast)
        
        while slow != fast:
            slow = self.get_sum_digit_sqr(slow)
            fast = self.get_sum_digit_sqr(fast)
            fast = self.get_sum_digit_sqr(fast)
        
        if slow == 1:
            return True
        else:
            return False
    
    def get_sum_digit_sqr(self, n):
        if len(str(n)) == 1:
            return n ** 2
        
        len_n = len(str(n))
        denominator = 10 ** (len_n-1)
        result = (n / denominator ) ** 2 + self.get_sum_digit_sqr(n % denominator)
        return result