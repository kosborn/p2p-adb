Just a quick explanation of how we generated the hash list
----------------------------------------------------------

 - Generate a full list of numbers (0000-8888 .. 000000000-888888888) (4.1 GB file!!)
 - Remove all lines with duplicate numbers, it's not possible to have duplicate numbers in one gesture. 
> Do an exclusive search on same character matches via grep.
> `grep -v "(.+).*\1" all_numbers > no_duplicates`
 - Remove all impossible combinations - 6302 is impossible, because it skips 1. 
> We do this by saying - Match on NOT 1 AND 02 or 20. That is impossible, so we then exclude that match. We do that for all crosses that are impossible.
> `grep -v "^(([^1]+(02|20))|([^4]+(08|80))|([^3]+(06|60))|([^4]+(17|71))|([^4]+(26|62))|([^4]+(35|53))|([^7]+(68|86))|([^5]+(28|82))).*$" no_duplicates > FINAL_BOSS`
 - Use `sed` to convert each character to escapable format
> `sed 's/\([0-9]\)/\\x0\1/g'  FINAL_BOSS > bytes_0x.out`
 - Use a python script to hash them all. All of this could coneivably be done in python, too, to speed up things and not worry about disk space... but fuck it, we'll do it live.
```python
import hashlib

with open('bytes_0x.out') as f:
	for line in f:
		print hashlib.sha1(line.rstrip().decode("string-escape")).hexdigest()
```
 - Combined them with `pr`
> `pr -m  -t -s" " bytes.out stage3_sha1 > gesture_hash.txt`




Screw math.
