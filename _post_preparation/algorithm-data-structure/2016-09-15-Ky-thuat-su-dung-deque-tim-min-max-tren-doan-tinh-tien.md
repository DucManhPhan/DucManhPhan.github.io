---
layout: post
title: Kỹ thuật sử dụng Deque tìm Min/Max trên đoạn tịnh tiến
bigimg: /img/image-header/california.jpg
tags: [Deque]
---

Kĩ thuật sử dụng Deque tìm Min/Max trên đoạn tịnh tiến xuất hiện nhiều trong các bài tập tin học, thông thường để cải tiến chương trình, làm giảm độ phức tạp. Chúng ta sẽ tìm hiểu kĩ thuật này qua một vài ví dụ cụ thể và xem xét khả năng mở rộng ứng dụng của nó trong các bài toán khác.

<br>

## Table of contents
- [Given problem](#given-problem)
- [Using brute force solution](#using-brute-force-solution)
- [Examples](#examples)
- [Wrapping up](#wrapping-up)


<br>

## Given problem

Dạng bài: Cho dãy số nguyên không âm A có n phần tử (n <= 10^6). Tìm L, R là 2 dãy số được hình thành từ A như sau:

```java
- 1 <= L[i] <= i <= R[i] <= n
- A[i] = min{A[L[i]], A[L[i]+1]…, A[R[i]]}
- Số lượng phần tử của A trong đoạn [L[i], R[i]] dài nhất
```

Yêu cầu: Xuất ra 2 dãy L, R.

<br>

## Using brute force solution

Bài tập trên cho thấy rõ công việc của kĩ thuật này: Với mỗi phần tử i của A, tìm đoạn [l, r] dài nhất sao cho i ∈ [l,r] và A[i] = min{A[l],…,A[r]}. Với n nhỏ (n <= 10^3 chẳng hạn) ta có thể giải quyết bằng cách: với mỗi i, ta kiểm tra các phần tử xung quanh i để mở rộng phạm vi l, r, cụ thể:

```java
for (int i = 1; i <= n; i++) {
    L[i] = i;
    while (L[i] > 0 && a[i] <= a[L[i]]) --L[i];
    ++L[i];

    R[i] = i;
    while (R[i] <= n && a[i] <= a[R[i]]) ++R[i];
    --R[i];
}
```

Nhận xét:
- **L[i] – 1** bằng 0 hoặc là số lớn nhất mà **L[i] – 1 < i** và **A[L[i] – 1] < A[i]** (1)
- **R[i] + 1**  bằng **n + 1** hoặc là số nhỏ nhất mà **R[i] + 1 > i** và **A[R[i] + 1] < A[i]** (2)

Từ nhận xét này, ta xây dựng Deque bằng cách "lọc" lại dãy như sau: trong quá trình duyệt dãy A, luôn đưa i vào cuối Deque hiện tại, nhưng loại bỏ hết tất cả các vị trí j đã được đưa vào trong Deque mà **A[j] >= A[i]**. Như vậy, tại mọi thời điểm i, ta luôn có danh sách các vị trí trên Deque tạo thành dãy các số tăng dần trên **A[1] -> A[i]**.

Ví dụ: A: 1 3 5 4 2 8 Deque và giá trị tương ứng trên A

```java
i = 1:   Deque=[1];         A=[1];
i = 2:   Deque=[1, 2];      A=[1, 3];
i = 3:   Deque=[1, 2, 3];   A=[1, 3, 5];
i = 4:   Deque=[1, 2, 4];   A=[1, 3, 4];
i = 5:   Deque=[1, 5];      A=[1, 2];
i = 6:   Deque=[1, 5, 6];   A=[1, 2, 8];

for (int i = 1; i <= n; ++i){
    while (top > 0 && a[D[top]] >= a[i]) --top;  //cap nhat Deque
    D[++top] = i; //dua i vao cuoi Deque
}
```

Theo cách hoạt động của Deque, ta có: Giả sử tại bước i, đã xác định được i ở vị trí top trong Deque. Khi đó: **L[i] = Deque[top – 1] + 1**.

Chứng minh:

Từ (1) ta có **A[L[i] – 1] < A[i]**, nên **L[i] – 1** không bị loại khỏi Deque trong quá trình cập nhật lại Deque. Mặc khác, cũng từ (1) ta có **A[L[i] – 1]** lớn nhất, mọi số **j ∈ [L[i], i – 1]** đều đã bị loại khỏi Deque vì **A[j] >= A[i]**. Sau đó ta đưa i vào vị trí cuối (top) của Deque, nên **L[i] – 1** chính bằng **Deque[top – 1]**, hay **L[i] = Deque[top – 1] + 1**.

Vậy, ta xác định được L của một phần tử bất kì ngay khi đưa phần tử đó vào Deque.

Bên cạnh đó, gọi t là vị trí các phần tử của A bị loại khỏi Deque trong quá trình cập nhật Deque. t bị loại khỏi Deque tại thời điểm i, chứng tỏ i là số đầu tiên xuất hiện trong Deque mà **A[i] < A[t]** (vì nếu tồn tại một số k thỏa **t < k < i** mà **A[k] < A[t]** thì t đã bị loại tại thời điểm k). Từ (2) ta suy ra **R[t] + 1** chính là i, hay: **R[t] = i – 1**;

Vậy, ta xác định được R của một phần tử bất kì khi loại phần tử đó ra khỏi Deque.

```java
D[0] = n+1;
for (int i = n; i >= 1; --i) {
    while (top > 0 && a[D[top]] >= a[i]) --top;
    R[i] = D[top] - 1;
    D[++top] = i;
}
```

Độ phức tạp của đoạn chương trình trên có thể đánh giá như sau: Với mỗi số ∈ dãy A ta chỉ đưa vào Deque 1 lần duy nhất và cũng chỉ lấy ra khỏi Deque 1 lần duy nhất. Do vậy chi phí thực hiện chỉ khoảng **2*n**, hay độ phức tạp chương trình là **O(n)**.

<br>

## Examples

Chúng ta xem các bài tập sau đây:

1. Áp dụng 1: [http://vn.spoj.com/problems/KAGAIN](http://vn.spoj.com/problems/KAGAIN)

    Tóm tắt đề: Cho dãy A gồm n phần tử.  Ta chọn các đoạn liên tiếp [i, j] bất kì. “Sức mạnh” của đoạn [i, j] được định nghĩa như sau: SM[i, j] = (j – i + 1) * min{A[i],…, A[j]}. Yêu cầu: Cho biết SM lớn nhất có thể trong dãy A.

    Giải: Để tìm kết quả, ta xét tất cả n trường hợp có A[k] chính bằng số người của đại đội ít nhất. “Sức mạnh” lớn nhất tại trường hợp k khi có dãy chọn dài nhất. Xây dựng mảng L, R và kiểm tra (R[i] – L[i]+1) * A[i] để tìm kết quả.

    Bài tập tương tự: [http://vn.spoj.com/problems/MINK](http://vn.spoj.com/problems/MINK)

2. Áp dụng 2: [http://vn.spoj.com/problems/QBRECT/](http://vn.spoj.com/problems/QBRECT/)

    Tóm tắt đề: Cho bảng số {0, 1} kích thước m x n. Tìm diện tích hình chữ nhật lớn nhất chỉ gồm các số 1 có cạnh song song với bảng.

    Giải: Trên dòng k, ta xét đoạn các cột [i, j] gồm các số 1 liên tiếp. Xét mỗi cột t ∈ [i, j], ta gọi H[t] = số dòng của đoạn liên tiếp dài nhất chỉ có số 1 kết thúc tại dòng k.

    ![](../img/Data-structure/queue/rectangle.png)
    Khi đó: Hình chữ nhật có thể tạo bởi đoạn [i,j] chính là hình có cạnh dài (j – i +1) và chiều cao bằng min{H[t]}. Diện tích hình chữ nhật này là (j – i + 1) * min{H[t]}.

    Với mỗi dòng trên hình chữ nhật, ta làm tương tự bài KAGAIN: xét hết tất cả m trường hợp có H[t] là min, tìm đoạn [i, j] dài nhất để có được hình chữ nhật lớn nhất. Để tiện tính toán, ta chuẩn bị trước H[t], thay vì là mảng một chiều ứng với cột t và tính lại với mỗi dòng k, ta mở rộng lưu trữ H[k][t] với ý nghĩa tương tự. Tính bảng H bằng quy hoạch động đơn giản: H[k][t] = 0 nếu A[k][t] = 0, ngược lại H[k][t] = H[k – 1][t] + 1. Việc chuẩn bị bảng H cũng như tìm hình chữ nhật là O(n^2), nên ta giải quyết bài tập này với O(n^2).

3. Bài tập tương tự

    [http://vn.spoj.com/problems/CREC01/](http://vn.spoj.com/problems/CREC01/)

    [http://vn.spoj.com/problems/CRECT/](http://vn.spoj.com/problems/CRECT/)

    [http://vn.spoj.com/problems/NKGOLF/](http://vn.spoj.com/problems/NKGOLF/)

    Một vài bài tập khác sử dụng Kĩ thuật tịnh tiến Deque

    [http://vn.spoj.com/problems/KDIFF/](http://vn.spoj.com/problems/KDIFF/)

    [http://vn.spoj.com/problems/BLAND](http://vn.spoj.com/problems/BLAND)

    [http://vn.spoj.com/problems/C11CIR/](http://vn.spoj.com/problems/C11CIR/)

<br>

## Wrapping up



<br>

Thanks for your reading.

<br>

Refer:

[https://langocthuyan.wordpress.com/2020/04/26/shortest-subarray-with-sum-at-least-k/](https://langocthuyan.wordpress.com/2020/04/26/shortest-subarray-with-sum-at-least-k/)

[https://vietcodes.github.io/code/3/index.html](https://vietcodes.github.io/code/3/index.html)

[https://vietcodes.github.io/code/60/index.html](https://vietcodes.github.io/code/60/index.html)