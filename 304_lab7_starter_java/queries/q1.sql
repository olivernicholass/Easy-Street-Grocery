SELECT os.orderId, os.orderDate, os.customerId, os.totalAmount, c.firstName, c.lastName
FROM ordersummary AS os
JOIN customer AS c ON c.customerId = os.customerId;



SELECT p.productName, p.productPrice, op.quantity, op.price*op.quantity AS pxq
FROM orderproduct AS op
JOIN product AS p ON p.productId = op.productId
ORDER BY orderId;
--WHERE op.orderId = 1;