package by.test;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotNull;

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

import com.by.Application;
import com.by.json.MemberDetailJson;
import com.by.model.Member;
import com.by.model.MemberDetail;
import com.by.service.MemberDetailService;
import com.by.service.MemberService;

/**
 * Created by yagamai on 15-11-24.
 */

@RunWith(SpringJUnit4ClassRunner.class)
@SpringApplicationConfiguration(classes = Application.class)
@WebIntegrationTest(randomPort = true)
@ActiveProfiles("test")
@SqlGroup({
        @Sql(executionPhase = Sql.ExecutionPhase.BEFORE_TEST_METHOD, scripts = "classpath:beforeTestRun.sql"),
        @Sql(executionPhase = Sql.ExecutionPhase.AFTER_TEST_METHOD, scripts = "classpath:afterTestRun.sql")
})
public class MemberDetailTest {
    @Autowired
    private MemberService memberService;
    @Autowired
    private MemberDetailService service;

    @Before
    public void before() {
        clearData();
        insertDate();
    }

    private void clearData() {
        MemberDetailJson detail = new MemberDetailJson();
        detail.setAddress("ahaha");
        detail.setRealName("tom");
        detail.setPassword("1");
        service.update(1l, detail);
        service.updatePassword(1l, detail);
    }

    private void insertDate() {
    }

    @Test
    public void getDetail() {
        Member member = memberService.findOneCache(1l);
        MemberDetail detail = member.getMemberDetail();
        assertNotNull(detail);
        assertEquals("tom", detail.getRealName());
    }

    @Test
    public void updateDetail() {
        MemberDetailJson detail = new MemberDetailJson();
        detail.setAddress("haha");
        detail.setPassword("123");
        detail.setRealName("peter");
        service.update(1l, detail);
        Member member = memberService.findOneCache(1l);
        MemberDetail d = member.getMemberDetail();
        assertEquals("peter", d.getRealName());
        assertEquals("haha", d.getAddress());
    }

    @Test
    public void updatePassword() {
        MemberDetailJson detail = new MemberDetailJson();
        detail.setAddress("cc");
        detail.setPassword("2");
        detail.setRealName("peter");
        service.updatePassword(1l, detail);
        Member member = memberService.findOneCache(1l);
        MemberDetail d = member.getMemberDetail();
        assertNotNull(d.getPassword());
        assertEquals("tom", d.getRealName());
        assertEquals("ahaha", d.getAddress());
    }
}
