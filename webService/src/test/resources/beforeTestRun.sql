INSERT INTO by_card (id, name, valid, init_score, img_href) VALUES (1, 'low23', 1, 100, '/img/1.png');

INSERT INTO by_category (id, name, type) VALUES (1, '交易规则', 'r'); -- trading
INSERT INTO by_category (id, name, type) VALUES (2, '注册规则', 'r'); -- register

-- valid rule
INSERT INTO by_rule (id, card_id, valid, beginTime, endTime, score, category_id, type, rate)
VALUES (1, 1, 1, '2016-1-1', '2016-12-31', 100, 1, 'c', 0);
-- invalid rule
INSERT INTO by_rule (id, card_id, valid, beginTime, endTime, score, category_id, type, rate)
VALUES (2, 1, 0, '2016-1-1', '2016-12-31', 200, 1, 'c', 0);
-- out of date rule
INSERT INTO by_rule (id, card_id, valid, beginTime, endTime, score, category_id, type, rate)
VALUES (3, 1, 1, '2015-1-1', '2015-12-31', 300, 1, 'c', 0);
INSERT INTO by_rule (id, card_id, valid, beginTime, endTime, score, category_id, type, rate)
VALUES (4, 1, 1, '2016-1-1', '2016-12-31', 0, 2, 'c', 1);

INSERT INTO by_member_detail (id, real_name, password, address, birthday)
VALUES (1, 'tom', '6b86b273ff34fce19d6b804eff5a3f5747ada4eaa22f1d49c01e52ddb7875b4b', 'ahaha', '2014-1-1');

INSERT INTO by_member (id, name, card_id, score, sumScore, detail_id) VALUES (1, '13611738433', 1, 200, 200, 1);

INSERT INTO by_score_add_history (id, member_id, created_time, total, reason) VALUES (1, 1, '2016-1-31', 200, 'haha');

INSERT INTO by_score_history (id, member_id, created_time, deposit, reason) VALUES (1, 1, '2016-1-31', 200, 'init');

INSERT INTO by_coupon (id, amount, score, begin_time, end_time, valid, name, type)
VALUES (1, 100, 10, '2016-1-1', '2016-12-31', 1, 'coupon1', 'p');
INSERT INTO by_coupon (id, amount, score, valid, name, type)
VALUES (2, 200, 20, 1, 'coupon2', 'p');
INSERT INTO by_coupon (id, amount, score, begin_time, end_time, valid, name, type)
VALUES (3, 100, 12, '2016-1-1', '2016-12-31', 1, 'coupon3', 'p');
INSERT INTO by_coupon (id, amount, score, begin_time, end_time, valid, name, type, coupon_end_time)
VALUES (8, 100, 11, '2016-1-1', '2016-12-31', 1, 'coupon8', 'p', '2016-12-31');
INSERT INTO by_coupon (id, amount, score, begin_time, end_time, valid, name, type, coupon_end_time)
VALUES (9, 1, 1, '2019-1-1', '2019-12-31', 1, 'coupon9', 'p', '2016-12-31');

INSERT INTO by_coupon (id, amount, score, begin_time, end_time, valid, name, type, duplicate, total)
VALUES (4, 100, 2, '2016-1-1', '2016-12-31', 1, 'giftCoupon1', 'g', 1, 0);
INSERT INTO by_coupon (id, amount, score, begin_time, end_time, valid, name, type, duplicate, total)
VALUES (5, 100, 2000, '2016-1-1', '2016-12-31', 1, 'giftCoupon2', 'g', 1, 0);
INSERT INTO by_coupon (id, amount, score, begin_time, end_time, valid, name, type, duplicate, total)
VALUES (6, 100, 2000, '2016-1-1', '2016-12-31', 0, 'giftCoupon3', 'g', 1, 0);
INSERT INTO by_coupon (id, amount, score, begin_time, end_time, valid, name, type, duplicate, total)
VALUES (7, 100, 2, '2016-1-1', '2016-12-31', 1, 'giftCoupon4', 'g', 0, 0);

INSERT INTO by_parking_coupon_member (member_id, coupon_id, total) VALUES (1, 1, 5);
INSERT INTO by_parking_coupon_member (member_id, coupon_id, total) VALUES (1, 2, 4);
INSERT INTO by_parking_coupon_member (member_id, coupon_id, total) VALUES (1, 3, 3);

INSERT INTO by_shop (id, name, shop_key, user_id, updated_time) VALUES (1, 'shop1', 'abc1', NULL, '2012-01-01');
INSERT INTO by_shop_coupon_member (id,member_id,coupon_id,exchanged_time,used_time,code) VALUES (1,1,5,'2015-12-21 00:00:00',null,'asdf1');
insert into by_shop_rule(shop_id,rule_id) values(1,1);

INSERT INTO by_trading (id, member_id, code, amount, shop_id, created_time)
VALUES (1, 1, 'a', 100, 1, '2015-12-25 12:34:22');

