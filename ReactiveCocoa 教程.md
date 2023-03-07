## ReactiveCocoa 教程

#### RACSignal

RACSignal（信号类），只是表示当数据变化时，信号内部会发出数据，它本身不具备发送信号的能力，而是交给内部一个订阅者 subscriber 去发出。

默认一个信号都是冷信号，就算是值改变了，但你没有订阅这个信号的话它也不会触发的，只有订阅了这个信号，才会变成热信号，值改变了才会触发。

使用步骤：

1、创建信号
sdasd
```objective-c
+ (RACSignal *)createSignal:(RACDisposable * (^)(id<RACSubscriber> subscriber))didSubscribe
```

2、订阅信号（才会激活信号）

```objective-c
- (RACDisposable *)subscribeNext:(void (^)(id x))nextBlock
```

3、发送信号

```objective-c
- (void)sendNext:(id)value
```

eg：

```objective-c
	// 1.创建信号
    // didSubscribe调用：只要一个信号被订阅了就会调用
    // didSubscribe作用：发送数据
    RACSignal *signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        // 3.发送信号
        [subscriber sendNext:@"111"];
        // 如果不再发送数据，最好发送信号完成，内部会自动调用 [RACDisposable disposable] 取消订阅信号
        [subscriber sendCompleted];
        
        // block调用：当信号发送完成或者发送错误时，就会自动执行这个block，取消订阅信号
        return [RACDisposable disposableWithBlock:^{
            // 执行完block后，当前信号就不再被订阅了
            NSLog(@"信号被销毁");
        }];
    }];
    // 2.订阅信号
    // nextBlock调用：每当有信号发出数据，就会调用block
    // nextBlock作用：处理数据，展示到 UI 上面
    [signal subscribeNext:^(id  _Nullable x) {
        // x：信号发送的内容
        NSLog(@"接收数据的值：%@", x);
    }];
```

> **RACSubscriber**
>
> 表示订阅者的意思，用于发送信号，这是一个协议，不是一个类，只要遵守这个协议，并且实现方法才能成为订阅者。
>
> 通过 `create` 创建的信号，都有一个订阅者，帮助他发送数据
>
> **RACDisposable**
>
> 用于取消订阅或者清理资源，当信号发送完成或者发送错误的时候，就会自动触发它。
>
> 使用场景：不想监听某个信号时，可以通过它主动取消订阅信号。





#### RACSubject



#### RACSequence



#### RACCommand

