package by.test;

import static org.junit.Assert.*;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.SpringApplicationConfiguration;
import org.springframework.boot.test.WebIntegrationTest;
import org.springframework.test.context.ActiveProfiles;
import org.springframework.test.context.jdbc.Sql;
import org.springframework.test.context.jdbc.SqlGroup;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.by.Application;
import com.by.model.ParkingCoupon;
import com.by.service.ParkingCouponService;

@RunWith(SpringJUnit4ClassRunner.class)
@SpringApplicationConfiguration(classes = Application.class)
@WebIntegrationTest(randomPort = true)
@ActiveProfiles("test")
@SqlGroup({ @Sql(executionPhase = Sql.ExecutionPhase.BEFORE_TEST_METHOD, scripts = "classpath:beforeTestRun.sql"),
		@Sql(executionPhase = Sql.ExecutionPhase.AFTER_TEST_METHOD, scripts = "classpath:afterTestRun.sql") })
public class ParkingCouponTest {
	@Autowired
	private ParkingCouponService service;

	@Test
	public void findActivate() {
		ParkingCoupon coupon = service.findActivate();
		assertEquals(1,coupon.getId());
	}
}
