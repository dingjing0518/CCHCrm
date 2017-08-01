package by.test;

import com.by.Application;
import com.by.exception.NotEnoughScoreException;
import com.by.model.Member;
import com.by.model.ParkingCoupon;
import com.by.model.ParkingCouponMember;
import com.by.model.ScoreHistory;
import com.by.service.*;
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

import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import static junit.framework.TestCase.assertEquals;
import static junit.framework.TestCase.assertTrue;

@RunWith(SpringJUnit4ClassRunner.class)
@SpringApplicationConfiguration(classes = Application.class)
@WebIntegrationTest(randomPort = true)
@ActiveProfiles("test")
@SqlGroup({
        @Sql(executionPhase = Sql.ExecutionPhase.BEFORE_TEST_METHOD, scripts = "classpath:beforeTestRun.sql"),
        @Sql(executionPhase = Sql.ExecutionPhase.AFTER_TEST_METHOD, scripts = "classpath:afterTestRun.sql")
})
public class ParkingCouponMemberTest {
    static Calendar end = Calendar.getInstance();
    static Calendar begin = Calendar.getInstance();
    static Calendar endOutOfDate = Calendar.getInstance();
    static Calendar beginOutOfDate = Calendar.getInstance();
    static Calendar today = Calendar.getInstance();

    static {
        begin.set(2016, 0, 1);
        end.set(2016, 11, 1);
        endOutOfDate.set(2015, 0, 1);
        beginOutOfDate.set(2015, 11, 1);
    }

    private ParkingCoupon coupon1, coupon2, coupon3, coupon4;
    private Member member = new Member(1l);
    @Autowired
    private MemberService memberService;
    @Autowired
    private ScoreAddHistoryService scoreAddHistoryService;
    @Autowired
    private ScoreHistoryService scoreHistoryService;
    @Autowired
    private ParkingCouponMemberService service;
    @Autowired
    private ParkingCouponService parkingCouponService;

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
        coupon1 = new ParkingCoupon();
        coupon1.setAmount(100d);
        coupon1.setScore(10);
        coupon1.setBeginTime(begin);
        coupon1.setEndTime(end);
        coupon1.setValid(ValidEnum.VALID);
        coupon1.setName("coupon1");

        coupon2 = new ParkingCoupon();
        coupon2.setAmount(200d);
        coupon2.setScore(20);
        coupon2.setValid(ValidEnum.VALID);
        coupon2.setName("coupon2");

        coupon3 = new ParkingCoupon();
        coupon3.setAmount(100d);
        coupon3.setScore(12);
        coupon3.setBeginTime(begin);
        coupon3.setEndTime(end);
        coupon3.setValid(ValidEnum.VALID);
        coupon3.setName("coupon3");
    }

    @Test
    public void findMinScoreParkingCouponTest() {
        List<ParkingCoupon> coupons = new ArrayList<>();
        assertTrue(coupon1.isEffective(today));
        assertTrue(coupon2.isEffective(today));
        coupons.add(coupon1);
        coupons.add(coupon2);
        coupons.add(coupon3);
        ParkingCoupon min = ParkingCoupon.minScoreCoupon(coupons);
        assertEquals(10, min.getScore().intValue());
    }

    @Test
    public void exchangeCoupon() {
        parkingCouponService.exchangeCoupon(member, new ParkingCoupon(1), 1);
        List<ParkingCouponMember> lists = service.findByMember(member);
        Member m = memberService.findOne(member.getId());
        assertEquals(3, lists.size());
        List<ScoreHistory> histories = scoreHistoryService.findByMember(member);
        assertEquals(2, histories.size());
        assertEquals(-10, histories.get(1).getDeposit());
        assertEquals(190, m.getScore());
        parkingCouponService.exchangeCoupon(member, new ParkingCoupon(1), 1);
        m = memberService.findOne(member.getId());
        assertEquals(180, m.getScore());
        lists = service.findByMember(member);
        assertEquals(3, lists.size());
        assertEquals(7, lists.get(0).getTotal());
        histories = scoreHistoryService.findByMember(member);
        assertEquals(3, histories.size());
        assertEquals(-10, histories.get(2).getDeposit());
    }

    @Test(expected = NotEnoughScoreException.class)
    public void exchangeCouponMoreThanScore() {
        parkingCouponService.exchangeCoupon(member, new ParkingCoupon(1), 100);
    }

    @Test
    public void findWhichToDelete() {
        List<ParkingCouponMember> lists = new ArrayList<>();
        ParkingCouponMember pcm4 = new ParkingCouponMember();
        pcm4.setTotal(4);
        ParkingCouponMember pcm1 = new ParkingCouponMember();
        pcm1.setTotal(1);
        ParkingCouponMember pcm2 = new ParkingCouponMember();
        pcm2.setTotal(2);
        ParkingCouponMember pcm3 = new ParkingCouponMember();
        pcm3.setTotal(3);
        pcm1.setMember(new Member(1l));
        pcm1.setCoupon(new ParkingCoupon(1));
        pcm2.setMember(new Member(1l));
        pcm2.setCoupon(new ParkingCoupon(1));
        pcm3.setMember(new Member(1l));
        pcm3.setCoupon(new ParkingCoupon(1));
        pcm4.setMember(new Member(1l));
        pcm4.setCoupon(new ParkingCoupon(1));
        lists.add(pcm4);
        lists.add(pcm1);
        lists.add(pcm2);
        lists.add(pcm3);
        List<ParkingCouponMember> i1 = ParkingCouponMember.findWhichToDelete(1, lists);
        assertEquals(1, i1.size());
        List<ParkingCouponMember> i2 = ParkingCouponMember.findWhichToDelete(5, lists);
        assertEquals(2, i2.size());
        assertEquals(4, i2.get(0).getTotal());
        assertEquals(1, i2.get(1).getTotal());
    }

    @Test
    public void deleteResult() {
        List<ParkingCouponMember> lists = service.findByMember(new Member(1l));
        assertEquals(3, lists.size());
        assertEquals(5, lists.get(0).getTotal());
        parkingCouponService.deleteResult(1, lists);
        List<ParkingCouponMember> lists2 = service.findByMember(new Member(1l));
        assertEquals(3, lists2.size());
        assertEquals(4, lists2.get(0).getTotal());
    }

    @Test
    public void useCoupon() {
        parkingCouponService.useCoupon(new Member(1l), 1, "123");
        List<ParkingCouponMember> lists2 = service.findByMember(new Member(1l));
        assertEquals(3, lists2.size());
        assertEquals(4, lists2.get(0).getTotal());
    }

}
