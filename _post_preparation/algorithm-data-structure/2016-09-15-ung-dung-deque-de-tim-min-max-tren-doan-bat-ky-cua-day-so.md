---
layout: post
title: Ứng dụng deque để tìm min, max trên đoạn bất kỳ của dãy số
bigimg: /img/image-header/california.jpg
tags: [Deque]
---



<br>

## Table of contents
- [Given problem](#given-problem)
- [Using Deque solution](#using-deque-solution)
- [Wrapping up](#wrapping-up)

<br>

## Given problem

Mình có đọc qua một bài hay về Deque và ứng dụng của nó ở blog của bạn Yên Vũ [ở đây](https://langocthuyan.wordpress.com/2014/08/12/ki-thuat-su-dung-deque-stack-2-dau-tim-minmax-tren-doan-tinh-tien/).

Bạn Vũ đã đặt vấn đề và chứng minh đầy đủ, để hiểu hơn bản chất của việc sử dụng Deque, cũng như thuật toán tìm Min/Max cho đoạn (i, j) bất kì của dãy số A; mình quyết định viết thêm bài này.

Tìm Min/Max trong đoạn bất kì của dãy số:

Xét dãy A sau đây: 1 3 5 4 2 8.

<br>

## Using Deque solution

Chúng ta sẽ xây dựng 2 Deque, tạm gọi là **dmax** và **dmin**, được xây dựng như sau:

- **dmin**: đưa chỉ số i vào cuối **dmin**, nhưng trước khi đưa thì lấy ra hết những chỉ số j đang có trong **dmin** mà **a[j] > a[i]**. ( > hay >= đều đúng về mặt bản chất, tuỳ từng bài toán mà ta xem xét nên sử dụng cho phù hợp ), tuy nhiên nên loại **a[j] > a[i]**.

- **dmax**: ngược lại với **dmin**, trước khi đưa i vào thì lấy ra tất cả những chỉ số j đang có trong **dmax** mà **a[j] < a[i]**.

Cuối cùng chúng ta sẽ có kết quả như sau:

|            |     Dmin     |     Dmax     |
| ---------- | ------------ | ------------ |
| i = 1      | 1            | 1            |
| i = 2      | 1 2          | 2            |
| i = 3      | 1 2 3        | 3            |
| i = 4      | 1 2 4        | 3 4          |
| i = 5      | 1 5          | 3 4 5        |
| i = 6      | 1 5 6        | 6            |

Tại bước thứ i, phần tử đầu tiên của dmin và dmax là chỉ số của 2 giá trị min và max trong đoạn **[1,i]**. Để tìm được 2 giá trị min/max cho đoạn **[j,i]** bất kì, chúng ta phân tích tiếp như sau:

Với dmin, tất cả chỉ số j : **dmin[i] < j < dmin[i+1]** đều thoả **a[j] > a[dmin[i+1]] > a[dmin[i]]**.
( Tương tự cho dmax, tất cả j : **dmax[i] < j < dmax[i+1]** đều thoả **a[j] < a[dmax[i+1]] < a[dmax[i]]**).

Như vậy, **dmin[i]** sẽ là phần tử nhỏ nhất của đoạn **[j,i]** với **dmin[i-1] < j <= dmin[i]**, **dmin[0] = 0**. ( Tương tự cho dmax )

Để thuận lợi, chúng ta sẽ thiết kế thuật toán sao cho **dmin.front() và dmax.front()** luôn là **min/max** của đoạn **[j,i]** đang xét.

Vậy chúng ta có giải thuật tìm min/max của đoạn **[j,i]** bất kì như sau:
- B1: Duyệt từ 1 đến i để xây dựng 2 deque dmin và dmax

- B2: Duyệt **k** từ **1** đến **j-1**, nếu **dmin.front() = k** hoặc **dmax.front() = k** thì **pop_front()** chỉ số đó ra.

Như vậy đến bước thứ **k**, **dmin.front()** và **dmax.front()** chính là min/max của đoạn **[j,i]**.

Ta có thể xét ví dụ tìm min/max của dãy A đã cho ở trên trong đoạn **[2,4]**.
- B1: Trạng thái của 2 deque dmin và dmax đã có ở trong bảng

- B2: Với **k = 1**, ta sẽ lấy phần tử đầu tiên của dmin ra, như vậy **a[dmin.front()] = a[2] = 3** lúc này là phần tử nhỏ nhất của đoạn **[x,4]** với **dmin[0] = 1 < x <= dmin[1] = 2**.

    **a[dmax.front()] = a[3] = 5** là phẩn tử lớn nhất của đoạn **[x,4]** với **dmax[-1] = 0 < x <= dmax[0] = 3**.

Code tham khảo:

```C++
void dequeMinMax(int* a, int n, int i, int j, int& min, int& max)
{
    deque<int> dmin, dmax;
    dmin.clear();
    dmax.clear();

    for (int cnt = 1; cnt <= i; cnt++)
    {
        while (dmin.size() && a[dmin.back()] > a[cnt]) dmin.pop_back();
        while (dmax.size() && a[dmax.back()] < a[cnt]) dmax.pop_back();
    }

    for (int cnt = 1; cnt < j; cnt++)
    {
        if (dmin.front() == cnt) dmin.pop_front();
        if (dmax.front() == cnt) dmax.pop_front();
    }

    min = dmin.front();
    max = dmax.front();

    dmin.clear();
    dmax.clear();
}
```

Đây cũng là kỹ thuật để làm bài KDIFF trên SPOJ: [http://vn.spoj.com/problems/KDIFF/](http://vn.spoj.com/problems/KDIFF/)

<br>

## Wrapping up



<br>

Thanks for your reading.

<br>

Refer:

[http://vn.spoj.com/problems/KDIFF/](http://vn.spoj.com/problems/KDIFF/)

[https://techmaster.vn/posts/34985/queue-hay-khong-queue](https://techmaster.vn/posts/34985/queue-hay-khong-queue)