# Estimate-square-roots-arm-asm
Estimating square roots written in ARM assembly

It is possible to estimate the square root of a value by subtracting sequential odd integers until the remainder reaches zero or becomes negative. If the remainder reaches exactly zero the exact root can be found.  If the remainder goes negative then the root is extimated to be between two integers.

For example, start with 16.

16 - 1 = 15  ->  1 subtraction<br>
15 - 3 = 12  ->  2 subtractions<br>
12 - 5 = 7   ->  3 subtractions<br>
7 - 7 = 0    ->  4 subtractions<br>

As the remainder is zero we know that the square root of 16 is 4

Now consider 20.  The square root of 20 is ~4.47

20 - 1 = 19  ->  1 subtraction<br>
19 - 3 = 16  ->  2 subtractions<br>
16 - 5 = 11  ->  3 subtractions<br>
11 - 7 = 4   ->  4 subtractions<br>
4 - 9 = -5   ->  5 subtractions<br>

As the remainder is less than zero we know the square root is not as great as 5 so it lies between 4 and 5.

Programming this is Python has been part of my courses for years as it is a nice use of loops and is generally done like this:
```python
# Estimating Square roots with While Loop

testValue = 25 
initialValue = testValue
rootCounter = 0 
subtractionValue = 1

while testValue >= subtractionValue: 
    testValue -= subtractionValue
    rootCounter += 1
    subtractionValue += 2

if testValue == 0: 
    print('The square root of',initialValue, 'is exactly', rootCounter)
else:
    print('The square root of', initialValue,'is between', rootCounter, 'and', rootCounter+1)
```

Now that I'm teaching myself ARM assembly this seemed like a good project to tackle. And why not take a project that can be written in 14 lines and replace it with one that takes nearly 130!

