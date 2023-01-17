class node:
    def __init__(self,newdata):
        self.data=newdata
        self.next=None
class linkedlist:
    def __init__(self):
        self.head=None
    def push(self,newdata):
        newnode=node(newdata)
        newnode.next=self.head
        self.head=newnode
    def print(self):
        a=self.head
        while(a):
            print(a.data,end=" ")
            a=a.next
    def rev(self,head):
        if head.data==None:
            return
        self.rev(head.next)
        print(head.data)

l=linkedlist()
l.push(1)
l.push(2)
l.push(7)
l.push(9)
l.rev(l)




    

    