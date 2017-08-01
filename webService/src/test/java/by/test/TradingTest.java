package by.test;

import com.by.Application;
import com.by.exception.ScoreAlreadyAddedException;
import com.by.form.ManualForm;
import com.by.json.TradingRequestJson;
import com.by.model.Member;
import com.by.model.Shop;
import com.by.model.ShopCouponMember;
import com.by.model.Trading;
import com.by.service.MemberService;
import com.by.service.ShopCouponMemberService;
import com.by.service.TradingService;
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

import static junit.framework.TestCase.assertEquals;
import static junit.framework.TestCase.assertNotNull;

/**
 * Created by yagamai on 16-3-9.
 */
@RunWith(SpringJUnit4ClassRunner.class)
@SpringApplicationConfiguration(classes = Application.class)
@WebIntegrationTest(randomPort = true)
@ActiveProfiles("test")
@SqlGroup({@Sql(executionPhase = Sql.ExecutionPhase.BEFORE_TEST_METHOD, scripts = "classpath:beforeTestRun.sql"),
        @Sql(executionPhase = Sql.ExecutionPhase.AFTER_TEST_METHOD, scripts = "classpath:afterTestRun.sql")})
public class TradingTest {
    Trading t;
    @Autowired
    private TradingService tradingService;
    @Autowired
    private MemberService memberService;
    @Autowired
    private ShopCouponMemberService shopCouponMemberService;

    @Before
    public void before() {
        t = new Trading();
        t.setAmount(100.0);
        t.setMember(new Member(1l));
        t.setShop(new Shop(1));
    }

    @Test(expected = ScoreAlreadyAddedException.class)
    public void manualAdd() {
        assertEquals(100, tradingService.tradeToScore(new Member(1l), new Shop(1), 100));
        ManualForm form = new ManualForm();
        form.setAmount(100.0);
        form.setMobile("13611738433");
        form.setFlowCode("a");
        form.setShopName("shop1");
//        tradingService.manualAddScore(form);
        assertEquals(300, memberService.findByName("13611738433").getScore());
//        tradingService.manualAddScore(form);
        assertEquals(300, memberService.findByName("13611738433").getScore());
    }

    @Test
    public void fromPoster() {
        TradingRequestJson json = new TradingRequestJson();
        json.setMobile("13611738433");
        json.setShopKey("abc1");
        json.setAmount(100);
        json.setCode(new String[]{"asdf1"});
        json.setCreatedTime("2016-02-12 12:23:22");
        tradingService.fromPoster(json);
        Member m = memberService.findByName("13611738433");
        ShopCouponMember scm = shopCouponMemberService.findByCode("asdf1");
        assertNotNull(scm.getTrading());
        assertEquals(300, m.getScore());
    }
}