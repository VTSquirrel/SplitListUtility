# SplitListUtility
This script will break up a large list of items into smaller sub-lists.

The split can be done by specifying a number of groups that the list should be divided into, or by specifying the number of items that should be in each group.

## Parameters
* [Required] ```Target``` - The target list to split. **Note**: The file must be a text file (".txt")
* [Optional] ```OutputDirectory``` - The location where the sub-list text files are saved. By default, this will be the same location as the script
* [Optional] ```Groups``` - The number of groups to split the list into. By default, this is equal to 2
* [Optional] ```ItemsPerGroup``` - The number of items that should be in each group. **Important**:
  * If a value for this paramater is specified, it will override the ```Groups``` paramater, no matter what the value for it is!

## Usage
For these examples, let's assume that our main target list (list.txt) has 10 items in it.

### Example 1
```
.\SplitList -Target "list.txt" 

[Info] User did not specify the number of items per group.
[Info] Will calculate items per group based on grouping of 2
--------------------------------------------------------------------------
Target: list.txt
Output Directory: C:\Users\VTSquirrel\Desktop\
Total Items: 10
# Groups: 2
# Items Per Group: 5
--------------------------------------------------------------------------
Running Group 1 {Start Index: 0; End Index: 4}...
	Items: 5
	Saved to file 'C:\Users\VTSquirrel\Desktop\Group 1.txt'
Running Group 2 {Start Index: 5; End Index: 9}...
	Items: 5
	Saved to file 'C:\Users\VTSquirrel\Desktop\Group 2.txt'

Done.
```
The output directory contains 2 files:
* Group 1.txt
  * Item 1
  * Item 2
  * Item 3
  * Item 4
  * Item 5
* Group 2.txt
  * Item 6
  * Item 7
  * Item 8
  * Item 9
  * Item 10

This used the default grouping of 2 and automatically calculated the number of items per group
