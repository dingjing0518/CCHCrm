package by.test;

import static junit.framework.TestCase.assertEquals;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.boot.test.SpringApplicationConfiguration;
import org.springframework.boot.test.WebIntegrationTest;
import org.springframework.test.context.ActiveProfiles;
import org.springframework.test.context.jdbc.Sql;
import org.springframework.test.context.jdbc.SqlGroup;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.by.Application;
import com.by.model.Card;
import com.by.model.CardRule;
import com.by.model.RuleCategory;
import com.by.typeEnum.ValidEnum;

/**
 * Created by yagamai on 15-12-7.
 */

@RunWith(SpringJUnit4ClassRunner.class)
@SpringApplicationConfiguration(classes = Application.class)
@WebIntegrationTest(randomPort = true)
@ActiveProfiles("test")
@SqlGroup({ @Sql(executionPhase = Sql.ExecutionPhase.BEFORE_TEST_METHOD, scripts = "classpath:beforeTestRun.sql"),
		@Sql(executionPhase = Sql.ExecutionPhase.AFTER_TEST_METHOD, scripts = "classpath:afterTestRun.sql") })
public class CouponServiceTest {
	private static Calendar beginTime = Calendar.getInstance();
	private static Calendar endTime = Calendar.getInstance();
	private static Calendar beginOut = Calendar.getInstance();
	private static Calendar endOut = Calendar.getInstance();
	private static Calendar beginFeature = Calendar.getInstance();
	private static Calendar endFeature = Calendar.getInstance();

	static {
		beginTime.set(2016, 0, 1);
		endTime.set(2016, 11, 31);
		beginOut.set(2015, 0, 1);
		endOut.set(2015, 11, 31);
		beginFeature.set(2017, 0, 1);
		endFeature.set(2017, 11, 31);
	}

	private RuleCategory registerCategory = new RuleCategory(10);
	private List<CardRule> rules = new ArrayList<>();
	private CardRule rule1, rule2, rule3, rule4;

	@Before
	public void before() {
		rule1 = new CardRule();
		rule1.setValid(ValidEnum.VALID);
		rule1.setRuleCategory(registerCategory);
		rule1.setBeginTime(beginTime);
		rule1.setEndTime(endTime);
		rule1.setRate(new Double(5));
		rule1.setScore(100);

		rule2 = new CardRule();
		rule2.setValid(ValidEnum.VALID);
		rule2.setRuleCategory(registerCategory);
		rule2.setBeginTime(beginTime);
		rule2.setEndTime(endTime);
		rule2.setRate(new Double(2));
		rule2.setScore(200);

		rule3 = new CardRule();
		rule3.setValid(ValidEnum.VALID);
		rule3.setRuleCategory(registerCategory);
		rule3.setBeginTime(beginOut);
		rule3.setEndTime(endOut);
		rule3.setRate(new Double(2));
		rule3.setScore(200);

		rule4 = new CardRule();
		rule4.setValid(ValidEnum.VALID);
		rule4.setRuleCategory(registerCategory);
		rule4.setBeginTime(beginFeature);
		rule4.setEndTime(endFeature);
		rule4.setRate(new Double(2));
		rule4.setScore(200);

		rules.add(rule1);
		rules.add(rule2);
		rules.add(rule3);
		rules.add(rule4);
	}

	@Test
	public void getMaxScoreTest() {
		assertEquals(200, Card.getMaxScore(rules));
	}

	@Test
	public void getMaxRateTest() {
		assertEquals(5.0, Card.getMaxRate(rules));
	}
}
