CREATE TABLE parents AS
  SELECT "abraham" AS parent, "barack" AS child UNION
  SELECT "abraham"          , "clinton"         UNION
  SELECT "delano"           , "herbert"         UNION
  SELECT "fillmore"         , "abraham"         UNION
  SELECT "fillmore"         , "delano"          UNION
  SELECT "fillmore"         , "grover"          UNION
  SELECT "eisenhower"       , "fillmore";

CREATE TABLE dogs AS
  SELECT "abraham" AS name, "long" AS fur, 26 AS height UNION
  SELECT "barack"         , "short"      , 52           UNION
  SELECT "clinton"        , "long"       , 47           UNION
  SELECT "delano"         , "long"       , 46           UNION
  SELECT "eisenhower"     , "short"      , 35           UNION
  SELECT "fillmore"       , "curly"      , 32           UNION
  SELECT "grover"         , "short"      , 28           UNION
  SELECT "herbert"        , "curly"      , 31;

CREATE TABLE sizes AS
  SELECT "toy" AS size, 24 AS min, 28 AS max UNION
  SELECT "mini"       , 28       , 35        UNION
  SELECT "medium"     , 35       , 45        UNION
  SELECT "standard"   , 45       , 60;

-------------------------------------------------------------
-- PLEASE DO NOT CHANGE ANY SQL STATEMENTS ABOVE THIS LINE --
-------------------------------------------------------------

-- The size of each dog
CREATE TABLE size_of_dogs AS
  SELECT dogs.name as name, sizes.size as size FROM dogs, sizes WHERE dogs.height > sizes.min AND dogs.height <= sizes.max;

-- All dogs with parents ordered by decreasing height of their parent
CREATE TABLE by_parent_height AS
  SELECT a.child FROM parents as a, dogs as b WHERE b.name = a.parent ORDER BY height DESC;

-- Filling out this helper table is optional
CREATE TABLE siblings AS
  SELECT a.child as sib1, b.child as sib2 from parents as a, parents as b where a.parent = b.parent and sib1 < sib2;

-- Sentences about siblings that are the same size
CREATE TABLE sentences AS
  SELECT a.sib1 || " and " || a.sib2  || " are " || b.size || " siblings" from siblings as a, size_of_dogs as b, size_of_dogs as c
    where b.name = a.sib1 and c.name = a.sib2 and b.size = c.size
    order by a.sib1;
-- Ways to stack 4 dogs to a height of at least 170, ordered by total height
CREATE TABLE stacks_helper(dogs, stack_height, last_height);

-- Add your INSERT INTOs here
  insert into stacks_helper select name, height, height from dogs;
  insert into stacks_helper select a.dogs || ', ' || b.name, a.stack_height + b.height, b.height
    from stacks_helper as a, dogs as b where a.last_height < b.height;
  insert into stacks_helper select a.dogs || ', ' || b.name, a.stack_height + b.height, b.height
    from stacks_helper as a, dogs as b where a.last_height < b.height;
  insert into stacks_helper select a.dogs || ', ' || b.name as D, a.stack_height + b.height, b.height
    from stacks_helper as a, dogs as b where a.last_height < b.height;


CREATE TABLE stacks AS
  SELECT dogs, stack_height from stacks_helper where stack_height > 170 order by stack_height;
