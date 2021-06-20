# Method 1, recursion
class Solution:
    def maxProfit(self, prices: List[int]) -> int:
        # Base case
        if len(prices) in [0, 1]:
            return 0
        if len(prices) == 2:
            return max(0, prices[1] - prices[0])

        length = len(prices)

        left = prices[:length // 2]
        right = prices[length // 2:]

        profit_left = self.maxProfit(left)
        profit_right = self.maxProfit(right)
        profit_middle = max(right) - min(left)

        profit = max([profit_left, profit_right, profit_middle])
        return profit

# Method 2
class Solution:
    def maxProfit(self, prices: List[int]) -> int:
        cummax = []
        max_reverse = 0

        if len(prices) == 1:
            return 0
        if len(prices) == 2:
            return max(0, prices[1] - prices[0])
        
        # cummax is the cumulative max from behind of prices 
        for i in range(len(prices)-1, -1, -1):
            if prices[i] > max_reverse:
                max_reverse = prices[i]
            cummax.append(max_reverse)
        cummax.reverse()

        profits = []
        for i in range(0, len(prices)-1):
            profits.append(max(0, cummax[i+1] - prices[i]))
        profit = max(profits)
        return profit

# Method 3, Kadane's algorithm
class Solution:
    def maxProfit(self, prices: List[int]) -> int:
        if len(prices) in [0, 1]:
            return 0
        if prices is None:
            return None

        # Creates a diff list
        prices_diff = []
        for i in range(1, len(prices)):
            prices_diff.append(prices[i] - prices[i-1])

        max_curr=prices_diff[0]
        max_global=prices_diff[0]

        for i in range(1, len(prices_diff)):
            max_curr = max(max_curr + prices_diff[i], prices_diff[i])
            max_global = max(max_curr, max_global)

        return max(0, max_global)
