package by.test;

import com.by.Application;
import com.by.json.LicenseJson;
import com.by.model.Member;
import com.by.model.ParkingCouponMember;
import com.by.service.LicenseService;
import com.by.service.ParkingCouponMemberService;
import com.by.service.ParkingCouponService;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.SpringApplicationConfiguration;
import org.springframework.boot.test.WebIntegrationTest;
import org.springframework.test.context.ActiveProfiles;
import org.springframework.test.context.jdbc.Sql;
import org.springframework.test.context.jdbc.SqlGroup;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.List;

import static junit.framework.TestCase.assertEquals;

/**
 * Created by yagamai on 16-2-1.
 */
@RunWith(SpringJUnit4ClassRunner.class)
@SpringApplicationConfiguration(classes = Application.class)
@WebIntegrationTest(randomPort = true)
@ActiveProfiles("test")
@SqlGroup({
        @Sql(executionPhase = Sql.ExecutionPhase.BEFORE_TEST_METHOD, scripts = "classpath:beforeTestRun.sql"),
        @Sql(executionPhase = Sql.ExecutionPhase.AFTER_TEST_METHOD, scripts = "classpath:afterTestRun.sql")
})
public class LicenseTest {
    @Autowired
    private ParkingCouponService parkingCouponService;
    @Autowired
    private ParkingCouponMemberService service;
    @Autowired
    private LicenseService licenseService;

    @Test
    public void useParkingCoupon() {
        parkingCouponService.useCoupon(new Member(1l), 1, "123");
        List<ParkingCouponMember> lists2 = service.findByMember(new Member(1l));
        List<LicenseJson> results = licenseService.findByMember(new Member(1l));
        assertEquals(1, results.size());
        parkingCouponService.useCoupon(new Member(1l), 1, "123");
        results = licenseService.findByMember(new Member(1l));
        assertEquals(1, results.size());
    }
}
