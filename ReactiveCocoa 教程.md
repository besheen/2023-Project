## ReactiveCocoa 教程

#### RACSignal

RACSignal（信号类），只是表示当数据变化时，信号内部会发出数据，它本身不具备发送信号的能力，而是交给内部一个订阅者 subscriber 去发出。

默认一个信号都是冷信号，就算是值改变了，但你没有订阅这个信号的话它也不会触发的，只有订阅了这个信号，才会变成热信号，值改变了才会触发。



#### RACSubject



#### RACSequence



#### RACCommand

