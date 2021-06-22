# Object Oriented Programming

class Fib():
    """A Fibonacci number.

    >>> start = Fib()
    >>> start
    0
    >>> start.next()
    1
    >>> start.next().next()
    1
    >>> start.next().next().next()
    2
    >>> start.next().next().next().next()
    3
    >>> start.next().next().next().next().next()
    5
    >>> start.next().next().next().next().next().next()
    8
    >>> start.next().next().next().next().next().next() # Ensure start isn't changed
    8
    """

    def __init__(self, value=0):
        self.value = value

    def next(self):
        if self.value == 0:
            new = Fib()
            new.value = 1
            new.previous = 0
        else:
            new = Fib()
            new.previous = self.value
            new.value = self.value + self.previous
        return new

    def __repr__(self):
        return str(self.value)

class VendingMachine:
    """A vending machine that vends some product for some price.

    >>> v = VendingMachine('candy', 10)
    >>> v.vend()
    'Machine is out of stock.'
    >>> v.deposit(15)
    'Machine is out of stock. Here is your $15.'
    >>> v.restock(2)
    'Current candy stock: 2'
    >>> v.vend()
    'You must deposit $10 more.'
    >>> v.deposit(7)
    'Current balance: $7'
    >>> v.vend()
    'You must deposit $3 more.'
    >>> v.deposit(5)
    'Current balance: $12'
    >>> v.vend()
    'Here is your candy and $2 change.'
    >>> v.deposit(10)
    'Current balance: $10'
    >>> v.vend()
    'Here is your candy.'
    >>> v.deposit(15)
    'Machine is out of stock. Here is your $15.'

    >>> w = VendingMachine('soda', 2)
    >>> w.restock(3)
    'Current soda stock: 3'
    >>> w.restock(3)
    'Current soda stock: 6'
    >>> w.deposit(2)
    'Current balance: $2'
    >>> w.vend()
    'Here is your soda.'
    """
    "*** YOUR CODE HERE ***"
    def __init__(self, item, cost):
        self.item = item
        self.cost = cost
        self.money = 0
        self.stock = 0

    def vend(self):
        if self.stock <= 0:
            if self.money:
                return 'Machine is out of stock. Here is your $' + str(self.money) + '.'
            return 'Machine is out of stock.'
        elif self.stock > 0:
            if self.money < self.cost:
                return 'You must deposit $' + str(self.cost - self.money) + ' more.'
            else:
                self.stock -= 1
                if self.money > self.cost:
                    display = 'Here is your ' + self.item + ' and $' + str(self.money - self.cost) + ' change.'
                if self.money == self.cost:
                    display = 'Here is your '+ str(self.item)+ '.'
                self.money = 0
                return display

    def deposit(self, d):
        if self.stock <= 0:
            return 'Machine is out of stock. Here is your $' + str(d) + '.'
        self.money += d
        return 'Current balance: $' + str(self.money)

    def restock(self, r):
        self.stock += r
        return 'Current ' + self.item + ' stock: ' + str(self.stock)
