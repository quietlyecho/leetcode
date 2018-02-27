#Source: https://leetcode.com/problems/best-time-to-buy-and-sell-stock/description/

class Solution(object):
    def maxProfit1(self, prices):
        """
        :type prices: List[int]
        :rtype: int
        """
        # brute force
        if prices == []:
            return 0
        else:
            profit = []
            for i_buy in range(0, len(prices)-1):
                for i_sell in range(i_buy+1, len(prices)):
                    profit.append( prices[i_sell] - prices[i_buy] )
                
            max_profit = max(max(profit), 0)
            
            return max_profit
        
    def maxProfit2(self, prices):
        """
        :type prices: List[int]
        :rtype: int
        """
        delta = [0]
        for i in range(1, len(prices)):
            delta.append(prices[i] - prices[i-1])
        
        # use Kadane's algorithm, because this problem now becomes the max contiguous subarray sum
        max_curr = delta[0]
        max_glob = delta[0]
        
        for i in range(1, len(delta)):
            max_curr = max(delta[i], max_curr + delta[i])
            max_glob = max(max_curr, max_glob)
        
        max_glob = max(0, max_glob)
        
        return max_glob
    
    
    def maxProfit(self, prices):
#        return self.maxProfit1(prices)
        return self.maxProfit2(prices)