import numpy as np
print(np.__version__)


#1dimensional array

array_1d= np.array([1,2,3,4,5])
print(array_1d.shape)
array_2d= np.array([[1,2,3],[4,5,6]])
print(array_2d.shape)
array_3d = np.array([[[1,2,3],[4,5,6]],[[7,8,9],[10,11,12]]])
print(array_3d.shape)
#size attribute

print(array_1d.size)
print(array_2d.size)
print(array_3d.size)
#dtype-data type

print(array_1d.dtype)
print(array_2d.dtype)
print(array_3d.dtype)
float_array=np.array([1.2,1.3,1.4])
print(float_array.dtype)
complex_array=np.array([1+2j,3+4j,6+7j])
print(complex_array.dtype)
boolean_array=np.array([True,False,True])
print(boolean_array.dtype)

#creating array with datatype specified

float32_array=np.array([1,2.4,2.7], dtype=np.float32)
print(float32_array.dtype)

int16_array= np.array([1,2,3],dtype=np.int16)
print(int16_array.dtype)

#creating array from a sequence
sequence_array=np.array((1,2,3,4,5))
print(sequence_array)


# From a list
list = [1, 2, 3, 4, 5,6]
list_array = np.asarray(list)
print(list_array)  

# from tuple
tuple =(10,20,30)
tuple_array = np.asarray(tuple)
print(tuple_array)

# creating an array with ones
ones_array=np.ones(5)
print(ones_array)
zeroes_array=np.zeros((2,3,2))
print(zeroes_array)
empty_array=np.empty((1,3))
print(empty_array)

#using  arange
range_array=np.arange(2,11,2)
print(range_array)

#using linscape
linscape_array=np.linspace(2,3,5)
print(linscape_array)

#square identity matrix np.eye()
a=np.eye(2)
print(a)

#basic array operations
a=np.array([1,2,3,4,5])
b=np.array([6,7,8,9,0])
print(a+b)
a = np.array([1, 2, 3, 4, 5])
b = np.resize(a, (3, 3))
print(b)
##################################################################################################################################################################################################

#Q1)Given a 3D array a with shape (2, 3, 4) and a 2D array b with shape (3, 4),
 #perform element-wise multiplication between a and b using broadcasting.
import numpy as np
a=np.random.randint (0,10 ,size=(2,3,4))
print(a)
print('###########################################################################################')
b=np.random.randint(0,10 ,size=(3,4))
print(b)
print('###########################################################################################')
print(a*b)

#Q2)Implement a function that takes two 2D arrays c and d with different shapes and performs element-wise operations
# (addition, subtraction, multiplication, and division) between them using broadcasting. Handle the case where broadcasting is not possible.

import numpy as np
a=np.random.randint(0,10,size=(2,3))
b=np.random.randint(0,10,size=(2,3))
try:
    
    print(a-b)
    print('***********************************')
    print(a*b)
    print('***********************************')
    print(a/b)
    print('***********************************')
    print(a+b)
except ValueError as e:
    print(e)

#Q3)Create a 2D array e with shape (5, 3) and a 1D array f with length 5. Compute the outer product of e and f using broadcasting.
import numpy as np
e=np.random.randint(0,10,size=(5,3))
f=np.arange(5) 
g = e[:, np.newaxis, :] * f[:, np.newaxis]
print(g)

#Indexing and Slicing:
#Given a 3D array g with shape (4, 3, 2), extract every other element along the first and second dimensions, but keep all elements along the third dimension.
import numpy as np
a=np.random.randint(0,10,size=(4,3,2))
print(a[::2, ::2, :])

#Create a function that takes a 2D array h and an array of row indices i and column indices j. The function should return a new array k where k[m, n] is the sum of the elements
#  in h along the diagonal specified by i[m] and j[n].


import numpy as np

h = np.array([
    [1, 2, 3],
    [4, 5, 6],
    [7, 8, 9]
])

i = [0, 2]
j = [1, 2]

k = np.zeros((len(i), len(j)))

for m in range(len(i)):
    for n in range(len(j)):
        row_index = i[m]
        col_index = j[n]
        
        diagonal_sum = 0
        x, y = row_index, col_index
        while x < h.shape[0] and y < h.shape[1]:
            diagonal_sum += h[x, y]
            x += 1
            y += 1
        
        k[m, n] = diagonal_sum

print("2D array h:")
print(h)
print("\nRow indices i:")
print(i)
print("\nColumn indices j:")
print(j)
print("\nResulting array k:")
print(k)


#Q3)Implement a function that takes a 2D array l and returns a new array m where each element in m 
# is the product of the corresponding row and column means in l.

import numpy as np


l = np.array([
    [1, 2, 3],
    [4, 5, 6],
    [7, 8, 9]
])

row_means = np.mean(l, axis=1, keepdims=True)
col_means = np.mean(l, axis=0, keepdims=True)
m = row_means * col_means
print("Original 2D array l:")
print(l)
print("\nArray m where each element is the product of corresponding row and column means:")
print(m)







# Array Manipulation:
# Q1)Given a 2D array n with shape (4, 6), reshape it into a 3D array with shape (2, 2, 6) and then flatten it back to a 2D array with shape (4, 6).
import numpy as np
n= np.random.randint(0,10,size=(4,6))
print(n)
print("******************************************************************************************")
n_reshape=n.reshape(2,2,6)
print(n_reshape)
print("******************************************************************************************")
print(n_reshape.reshape(4,6))

#Q2) Implement a function that takes a 2D array o and rolls it along the first axis by a specified number of positions. For example,
# if the input array is [[1, 2, 3], [4, 5, 6]] and the number of positions is 1, the output should be [[4, 5, 6], [1, 2, 3]].
import numpy as np
o = np.array([[1, 2, 3],[4, 5, 6],[7, 8, 9]])
o_rolled=np.roll(o,1,axis=0)
print(o_rolled)

# Q3)Create a function that takes a 2D array p and replaces all occurrences of a specified value x with the mean of the neighboring elements (horizontally and vertically) in the array.
import numpy as np

p = np.array([
    [1, 2, 3],
    [4, 5, 2],
    [7, 8, 9]
])

p_copy = p.copy()
rows, cols = p.shape

for i in range(rows):
    for j in range(cols):
        if p[i, j] == 2:
            neighbors = []
            if j > 0:
                neighbors.append(p[i, j - 1])
            if j < cols - 1:
                neighbors.append(p[i, j + 1])
            if i > 0:
                neighbors.append(p[i - 1, j])
            if i < rows - 1:
                neighbors.append(p[i + 1, j])
            
            if neighbors:
                mean_value = np.mean(neighbors)
                p_copy[i, j] = mean_value

print("Original 2D array p:")
print(p)
print("\nArray after replacing occurrences of 2 with the mean of the neighbors:")
print(p_copy)

