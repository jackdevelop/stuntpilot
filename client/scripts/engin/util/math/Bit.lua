-- peter _@_ wapeter.com   2013-11-27

-- ref:  

-- http://www.cppblog.com/zhenyu/archive/2009/05/20/1050.html

-- modified version, with faster binary/decimal left/right shift

-- bug fix on n=0 case

 

local bit = { data32 = {} };

 

for i=1,32 do

    bit.data32[i] = 2^(32-i);

    -- print(bit.data32[i]);

end

 

-- from decimal num to bit_array(ba)

function bit:d2b(num)

    local ba = {};

    if (num/2) >= self.data32[1] then

        print('BUG bit:d2b overflow: ', num);

        return nil;

    end

    for i=1, 32 do

        if num >= self.data32[i] then

            ba[i] = 1;

            num = num-self.data32[i];

        else

            ba[i] = 0;

        end

    end

    return ba;

end

 

-- binary to decimal

function    bit:b2d(ba)

    local   num=0

    for i=1,32 do

        if ba[i] ==1 then

        num=num+2^(32-i)

        end

    end

    return  num

end   --bit:b2d

 

 

-- binary array clone

function bit:bclone(ba)

    local r = {};

    for i=1,32 do

        r[i] = ba[i];

    end

    return r;

end

 

-- return 1 if op1 > op2

-- return -1 if op1 < op2

-- return 0 if op1==op2

function bit:bcompare(op1, op2)

    local v;

    for i=1, 32 do

        v = op1[i] - op2[i];

        if v ~= 0 then

            return v;

        end

    end

    return 0;

end

 

-- binary xor : input, output are binary array

function    bit:bxor(op1,op2) -- {

    local r = {};

    for i=1,32 do

        if op1[i]==op2[i] then

            r[i]=0

        else

            r[i]=1

        end

    end

    return r;

end -- bit:bxor }

 

 

-- decimal xor : input, output are decimal

function    bit:dxor(a,b)

    local   op1=self:d2b(a)

    local   op2=self:d2b(b)

    local   r={}

 

    for i=1,32 do

        if op1[i]==op2[i] then

            r[i]=0

        else

            r[i]=1

        end

    end

    return  self:b2d(r)

end --bit:dxor }

 

function bit:band(op1, op2) -- {

    local   r={}

    for i=1,32 do

        if op1[i]==1 and op2[i]==1  then

            r[i]=1

        else

            r[i]=0

        end

    end

    return  r;

end -- bit:band }

 

 

 

function    bit:dand(a,b) -- {

    local   op1=self:d2b(a)

    local   op2=self:d2b(b)

    local   r={}

 

    for i=1,32 do

        if op1[i]==1 and op2[i]==1  then

            r[i]=1

        else

            r[i]=0

        end

    end

    return  self:b2d(r)

 

end -- bit:dand }

 

 

function bit:bor(op1, op2) -- {

    local   r={}

    for i=1,32 do

        if  op1[i]==1 or op2[i]==1   then

            r[i]=1

        else

            r[i]=0

        end

    end

    return  r

end -- bit:bor }

 

function    bit:dor(a,b) -- {

    local   op1=self:d2b(a)

    local   op2=self:d2b(b)

    local   r={}

 

    for i=1,32 do

        if  op1[i]==1 or   op2[i]==1   then

            r[i]=1

        else

            r[i]=0

        end

    end

    return  self:b2d(r)

end --bit:dor }

 

 

function    bit:bnot(op1) -- {

    local   r={}

 

    for i=1,32 do

        if  op1[i]==1   then

            r[i]=0

        else

            r[i]=1

        end

    end

    return  r

end --bit:bnot }

 

 

function    bit:dnot(a) -- {

    local   op1=self:d2b(a)

    local   r={}

 

    for i=1,32 do

        if  op1[i]==1   then

            r[i]=0

        else

            r[i]=1

        end

    end

    return  self:b2d(r)

end --bit:dnot -- }

 

 

function bit:bright_slow(op1, n) -- {

    if n > 32 or n < 0 then

        return self:d2b(0);

    end

 

    local   r=bit:bclone(op1);

    for j=1,n do

        for i=31,1,-1 do

            r[i+1]=r[i]

        end

        r[1]=0

    end

    return r

end -- bit:bright_slow }

 

function bit:bright(op1, n) -- {

    if n > 32 or n < 0 then

        return self:d2b(0);

    end

    local   r=bit:bclone(op1);

 

    for i=32,1+n,-1 do

        r[i]=r[i-n]

    end

    for i=1,n do

        r[i]=0

    end

    return r

end -- bit:bright }

 

 

function    bit:dright(a,n) -- {

    -- assume n >= 0, negative n will result 0

    if n > 32 or n < 0 then

        return 0; -- hard coded

    end

 

    local   r=self:d2b(a)

    for i=32, 1+n, -1 do

        r[i] = r[i-n]

    end

    for i=1,n do

        r[i] = 0

    end

    return  self:b2d(r)

end --bit:dright }

 

function    bit:dright_slow(a,n) -- {

    local   op1=self:d2b(a)

    local   r=self:d2b(0)

 

    if n < 32 and n >= 0 then

        for j=1,n do

            for i=31,1,-1 do

                op1[i+1]=op1[i]

            end

            op1[1]=0

        end

    r=op1

    end

    return  self:b2d(r)

end --bit:dright_slow }

 

 

function bit:bleft(op1, n)

    if n > 32 or n < 0 then

        return self:d2b(0);

    end

    local r = bit:bclone(op1);

    for i=1,32-n do

        r[i] = r[i+n];

    end

 

    for i=33-n, 32 do

        r[i] = 0;

    end

    return r;

end

 

function bit:dleft(a, n)

    if n > 32 or n < 0 then

        return 0;

    end

 

    local op1=self:d2b(a)

 

    for i=1,32-n do

        op1[i] = op1[i+n];

    end

 

    for i=33-n, 32 do

        op1[i] = 0;

    end

 

    return self:b2d(op1);

end

 

 

function    bit:dleft_slow(a,n)

    local   op1=self:d2b(a)

    local   r=self:d2b(0)

 

    if n < 32 and n >= 0 then

        for j=1,n   do

            for i=1,31 do

                op1[i]=op1[i+1]

            end

            op1[32]=0

        end

    r=op1

    end

    return  self:b2d(r)

end --bit:dleft_slow

 

 

function bit:bstr(ba, sep)

    local str = ''

    for i=1,32 do

        str = str  .. ba[i]

        if (i % 4)==0 and i~=32 and sep ~= nil then

            str = str .. sep;

        end

    end

    return str;

end

 

 

 

 

function bit:test2(num)

    local ba;

    local r1, r2;

    local result = 0;

    local cmp;

    print('Case 2, compare fast and slow bright:');

    -- 1101_1100_1010_0010_0001_0001_0001_0101

    ba = bit:d2b(3701608725);

    print(bit:bstr(ba, '_'));

 

    for i=-10,50 do

        r1 = bit:bright(ba, i);

        r2 = bit:bright_slow(ba, i);

        cmp = bit:bcompare(r1, r2);

        if cmp ~= 0 then

            -- print('BUG cmp = ', cmp, '  i=', i);

            -- print(bit:bstr(r1, '_'));

            -- print(bit:bstr(r2, '_'));

            result = result - 1;

        end

    end

    return result;

end

 

 

function bit:test3(num)

    local v1, v2;

    local cmp;

    print('case 3: compare dright');

 

    -- for i=0, 4294967295 do

    -- for i=10000, 20000 do  -- ok with n=1,31

    -- for i=10000, 20000 do  -- ok with n=0,33

    -- for i=3701598725,3701608725 do -- ok with n=0,33

    for i=4294957295, 4294967295 do -- ok with n=0,33

        -- print(i);

        for n=0, 33 do

            v1 = bit:dright(i, n);

            v2 = bit:dright_slow(i, n);

            cmp = v1 - v2;

            if cmp ~= 0 then

                print('BUG test3 cmp=', cmp, 'i,n=', i, n);

                print('v1,v2: ', v1, v2);

            end

        end

    end

end

 

function bit:test4(num)

    local v1, v2;

    local cmp;

    print('case 4 compare dleft');

 

    for i=4294957295, 4294967295 do -- ok with n=0,33

        -- print(i);

        for n=0, 33 do

            v1 = bit:dleft(i, n);

            v2 = bit:dleft_slow(i, n);

            cmp = v1 - v2;

            if cmp ~= 0 then

                print('BUG test4 cmp=', cmp, 'i,n=', i, n);

                print('v1,v2: ', v1, v2);

            end

        end

    end

end

 

 

 

function bit:test5(num)

    local v1, v2;

    local cmp;

    print('case 5 compare bleft');

 

    for i=4294957295, 4294967295 do -- ok with n=0,33

        -- print(i);

        local ba = bit:d2b(i);

        for n=0, 33 do

            v1 = bit:b2d(bit:bleft(ba, n));

            v2 = bit:dleft(i, n);

            cmp = v1 - v2;

            if cmp ~= 0 then

                print('BUG test5 cmp=', cmp, 'i,n=', i, n);

                print('v1,v2: ', v1, v2);

            end

        end

    end

end

 

return bit;
-- to use test case: 

-- bit:test5(1)