class Solution(object):
    def fizzBuzz(self, n):
        """
        :type n: int
        :rtype: List[str]
        """
	str_list = []
	for i in range(1, n+1):
		if i % 3 == 0 and i % 5 != 0:
			str_list.append('Fizz')
		elif i % 3 != 0 and i % 5 == 0:
			str_list.append('Buzz')
		elif i % 3 == 0 and i % 5 == 0:
			str_list.append('FizzBuzz')
		else:
			str_list.append(str(i))
	#print 'n = %1.0f,\n\nReturn:\n' %(n)
	output = ''
	for i in range(1, n+1):
		if n == 1:
			output = (str_list[i-1])
		elif n > 1:
			if i == 1:
				output += (str_list[i-1] + ",")
			if i == n:
				output += (str_list[i-1])
			else:
				output += (str_list[i-1] + ",")	
	return(output)

sol = Solution()
print sol.fizzBuzz(1)	
