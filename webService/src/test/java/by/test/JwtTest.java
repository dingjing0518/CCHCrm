package by.test;

import com.by.Application;
import com.by.model.Member;
import com.by.service.MemberService;
import com.by.utils.JWTUtils;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.SpringApplicationConfiguration;
import org.springframework.boot.test.WebIntegrationTest;
import org.springframework.test.context.ActiveProfiles;
import org.springframework.test.context.jdbc.Sql;
import org.springframework.test.context.jdbc.SqlGroup;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import static org.junit.Assert.assertNotNull;

@RunWith(SpringJUnit4ClassRunner.class)
@SpringApplicationConfiguration(classes = Application.class)
@WebIntegrationTest(randomPort = true)
@ActiveProfiles("test")
@SqlGroup({
        @Sql(executionPhase = Sql.ExecutionPhase.AFTER_TEST_METHOD, scripts = "classpath:afterTestRun.sql")
})
public class JwtTest {
    @Autowired
    private MemberService memberService;

    @Test
    public void jwt() {
        Member m = memberService.findOne(1l);
        String code = JWTUtils.encode(m);
        System.out.println(code);
        assertNotNull(code);
        Member m2 = memberService.findOne(2l);
        String code2 = JWTUtils.encode(m2);
        System.out.println(code2);
        assertNotNull(code2);
    }
}