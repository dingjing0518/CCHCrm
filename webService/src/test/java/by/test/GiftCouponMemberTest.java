package by.test;

import com.by.Application;
import com.by.exception.AlreadyExchangeException;
import com.by.exception.NotEnoughScoreException;
import com.by.exception.NotValidException;
import com.by.model.*;
import com.by.service.*;
import com.by.typeEnum.DuplicateEnum;
import com.by.typeEnum.ScoreHistoryEnum;
import com.by.typeEnum.ValidEnum;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.SpringApplicationConfiguration;
import org.springframework.boot.test.WebIntegrationTest;
import org.springframework.test.context.ActiveProfiles;
import org.springframework.test.context.jdbc.Sql;
import org.springframework.test.context.jdbc.SqlGroup;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.Calendar;
import java.util.List;

import static junit.framework.TestCase.assertEquals;

@RunWith(SpringJUnit4ClassRunner.class)
@SpringApplicationConfiguration(classes = Application.class)
@WebIntegrationTest(randomPort = true)
@ActiveProfiles("test")
@SqlGroup({
        @Sql(executionPhase = Sql.ExecutionPhase.BEFORE_TEST_METHOD, scripts = "classpath:beforeTestRun.sql"),
        @Sql(executionPhase = Sql.ExecutionPhase.AFTER_TEST_METHOD, scripts = "classpath:afterTestRun.sql")
})
public class GiftCouponMemberTest {
    static Calendar end = Calendar.getInstance();
    static Calendar begin = Calendar.getInstance();
    static Calendar endOutOfDate = Calendar.getInstance();
    static Calendar beginOutOfDate = Calendar.getInstance();

    static {
        begin.set(2016, 0, 1);
        end.set(2016, 11, 1);
        endOutOfDate.set(2015, 0, 1);
        beginOutOfDate.set(2015, 11, 1);
    }

    private GiftCoupon giftCoupon1, giftCoupon2, giftCoupon3, giftCoupon4;
    private Member member = new Member(1l);
    @Autowired
    private GiftCouponMemberService service;
    @Autowired
    private MemberService memberService;
    @Autowired
    private ScoreAddHistoryService scoreAddHistoryService;
    @Autowired
    private ScoreHistoryService scoreHistoryService;

    @Before
    public void before() {
        clearDate();
        insertDate();
    }

    private void clearDate() {
        Member member = memberService.findOne(1l);
        member.setScore(200);
        memberService.update(member);
        scoreAddHistoryService.deleteByMember(member);
        scoreAddHistoryService.save(member, 200, "init");
        scoreHistoryService.deleteByMember(member);
        scoreHistoryService.save(member, 200, "init", ScoreHistoryEnum.ADMIN);
    }

    private void insertDate() {
        giftCoupon1 = new GiftCoupon();
        giftCoupon1.setAmount(100d);
        giftCoupon1.setBeginTime(begin);
        giftCoupon1.setEndTime(end);
        giftCoupon1.setDuplicate(DuplicateEnum.ISDUPLICATE);
        giftCoupon1.setScore(2);
        giftCoupon1.setValid(ValidEnum.VALID);
        giftCoupon1.setName("giftCoupon1");
        giftCoupon1.setTotal(0);

        giftCoupon2 = new GiftCoupon();
        giftCoupon2.setAmount(100d);
        giftCoupon2.setBeginTime(begin);
        giftCoupon2.setEndTime(end);
        giftCoupon2.setDuplicate(DuplicateEnum.ISDUPLICATE);
        giftCoupon2.setScore(2000);
        giftCoupon2.setValid(ValidEnum.VALID);
        giftCoupon2.setName("giftCoupon2");
        giftCoupon2.setTotal(0);

        giftCoupon3 = new GiftCoupon();
        giftCoupon3.setAmount(100d);
        giftCoupon3.setBeginTime(begin);
        giftCoupon3.setEndTime(end);
        giftCoupon3.setDuplicate(DuplicateEnum.ISDUPLICATE);
        giftCoupon3.setScore(2000);
        giftCoupon3.setValid(ValidEnum.INVALID);
        giftCoupon3.setName("giftCoupon3");
        giftCoupon3.setTotal(0);

        giftCoupon4 = new GiftCoupon();
        giftCoupon4.setAmount(100d);
        giftCoupon4.setBeginTime(begin);
        giftCoupon4.setEndTime(end);
        giftCoupon4.setDuplicate(DuplicateEnum.NOTDUPLICATE);
        giftCoupon4.setScore(2);
        giftCoupon4.setValid(ValidEnum.VALID);
        giftCoupon4.setName("giftCoupon4");
        giftCoupon4.setTotal(10);
    }

    @Test(expected = NotEnoughScoreException.class)
    public void exchangeGiftCouponNotEnoughScore() {
        service.exchangeCoupon(new GiftCoupon(4), member, 1000);
    }

    @Test(expected = NotValidException.class)
    public void exchangeGiftCouponNotValid() {
        service.exchangeCoupon(new GiftCoupon(6), member, 1000);
    }

    @Test(expected = AlreadyExchangeException.class)
    public void duplicateExchange() {
        service.exchangeCoupon(new GiftCoupon(7), member, 1);
        service.exchangeCoupon(new GiftCoupon(7), member, 1);
    }

    @Test
    public void exchangeCoupon() {
        service.exchangeCoupon(new GiftCoupon(7), member, 1);
        List<GiftCouponMember> coupons = service.findByCouponAndMember(new GiftCoupon(7), member);
        List<ScoreAddHistory> addHistories = scoreAddHistoryService.findByMember(member);
        List<ScoreHistory> histories = scoreHistoryService.findByMember(member);
        Member m = memberService.findOne(member.getId());
        assertEquals(1, coupons.size());
        assertEquals(200 - 2, m.getScore());
        assertEquals(1, addHistories.size());
        assertEquals(198, addHistories.get(0).getTotal());
        assertEquals(2, histories.size());
        assertEquals(-2, histories.get(1).getDeposit());
    }
}
