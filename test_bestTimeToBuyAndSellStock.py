import unittest
from bestTimeToBuyAndSellStock import Solution

# Unit tests for function last_position()
class test_max_profits(unittest.TestCase):
    def test_1(self):
        s=Solution()
        prices = [7, 1, 5, 3, 6, 4]
        expected_output = 5
        self.failUnless(s.maxProfit(prices)==expected_output)

    def test_2(self):
        s=Solution()
        prices = [7, 6, 4, 3, 1]
        expected_output = 0
        self.failUnless(s.maxProfit(prices)==expected_output)

def main():
    unittest.main()

if __name__ == '__main__':
    main()