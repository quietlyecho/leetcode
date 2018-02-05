class Solution(object):
    def titleToNumber(self, s):
        """
        :type s: str
        :rtype: int
        """
	# each letter represents a number, get the number
	all_letters = ('A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z')	
	letter_number_map = {}
	for letter in all_letters:
		letter_number_map[ letter ] = ord( letter ) - ord( 'A' ) + 1	 
	# each combination of letter represents a number, get that formula
	str_len = len(s)
	base = len(all_letters) 
	column_number = 0
	for i in range(0, str_len):
		column_number += letter_number_map[ s[i] ]*(base ** (str_len - 1 - i))
	return(column_number)

s_1 = Solution()
print 'A : %1.0f' %(s_1.titleToNumber(s='A'))
print 'AA: %1.0f' %(s_1.titleToNumber(s='AA'))

