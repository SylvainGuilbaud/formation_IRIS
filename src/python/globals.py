import iris

args = {'hostname':'127.0.0.1', 'port':12772,
    'namespace':'USER', 'username':'_SYSTEM', 'password':'SYS'
    }

conn = iris.connect(**args)

# Create an iris object
irispy = iris.createIRIS(conn)

# Create a global array in the USER namespace on the server
irispy.set('A', 'root', 'foo', 'SubFoo')

irispy.set(123, 'root', 'bar', 'lowbar', 'UnderBar')
irispy.set(124, 'root', 'bar', 'lowbar', 'UnderBar2')
irispy.set("hi", 'root', 'bar', 'lowbar')
irispy.set("hi again", 'root', 'bar3')

# Read the values from the database and print them
subfoo_value = irispy.get('root', 'foo', 'SubFoo')
underbar_value = irispy.get('root', 'bar', 'lowbar', 'UnderBar')
underbar2_value = irispy.get('root', 'bar', 'lowbar', 'UnderBar2')
lowbar_value = irispy.get('root', 'bar', 'lowbar')
bar3_value = irispy.get('root', 'bar3')

print('Created two values: ')

print('   root("foo","SubFoo")=', subfoo_value)
print('   root("bar","lowbar","UnderBar")=', underbar_value)
print('   root("bar","lowbar","UnderBar2")=', underbar2_value)
print('   root("bar","lowbar")=', lowbar_value)
print('   root("bar3")=', bar3_value)

direction = 0 # direction of iteration (boolean forward/reverse)
next_sub = chr(0) # start at first possible subscript
subs = []

print("\n Iterating root \n")

isDef = irispy.isDefined('root', *subs)

while isDef:

    next_sub = irispy.nextSubscript(False, 'root', *subs, next_sub) # get first subscript

    if next_sub == None: # we finished iterating nodes on this tree branch, move a level up
        if len(subs) == 0: # no more things to iterate
            break 
        next_sub = subs.pop(-1) # pop last subscript in order to continue iterating this level
        if irispy.isDefined('root', *subs, next_sub) == 11:
            print('root(',*subs, next_sub, ')=',irispy.get('root', *subs, next_sub))
            continue
        continue

    isDef = irispy.isDefined('root', *subs, next_sub)

    if isDef in [10, 11]: # keep building subscripts for depth first search
        subs.append(next_sub)
        next_sub = chr(0)
        continue
    elif isDef == 1: # reached a leaf node, print it
        print('root(',*subs, next_sub, ')=',irispy.get('root', *subs, next_sub))
    else: # def 0 is not really expected
         print("error")
         irispy.kill('root')
         conn.close()
         exit(-1)

        

# Delete the global array and terminate
# irispy.kill('root') # delete global array root

conn.close()