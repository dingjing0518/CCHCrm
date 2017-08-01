package by.test;

import com.by.Application;
import com.by.model.*;
import com.by.service.CardService;
import com.by.service.MemberService;
import com.by.service.ScoreAddHistoryService;
import com.by.service.ScoreHistoryService;
import com.by.typeEnum.ScoreHistoryEnum;
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

/**
 * Created by yagamai on 15-11-25.
 */

@RunWith(SpringJUnit4ClassRunner.class)
@SpringApplicationConfiguration(classes = Application.class)
@WebIntegrationTest(randomPort = true)
@ActiveProfiles("test")
@SqlGroup({
        @Sql(executionPhase = Sql.ExecutionPhase.BEFORE_TEST_METHOD, scripts = "classpath:beforeTestRun.sql"),
        @Sql(executionPhase = Sql.ExecutionPhase.AFTER_TEST_METHOD, scripts = "classpath:afterTestRun.sql")
})
public class MemberServiceTest {
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

    @Autowired
    private MemberService service;
    @Autowired
    private ScoreAddHistoryService scoreAddHistoryService;
    @Autowired
    private ScoreHistoryService scoreHistoryService;
    @Autowired
    private CardService cardService;

    @Before
    public void before() {
        clearData();
        insertDate();
    }

    private void clearData() {
        scoreAddHistoryService.deleteAll();
        scoreHistoryService.deleteAll();
    }

    private void insertDate() {
    }

    @Test
    public void signUpTest() {
        Member member = new Member();
        member.setName("11112222223");
        member.setMemberDetail(new MemberDetail());
        member.setCard(new Card(1));
        Member m = service.save(member);
        m = cardService.addSignUpScore(m);
        assertEquals(200, m.getScore());
        assertEquals(200, m.getSumScore());
        List<ScoreAddHistory> addHistories = scoreAddHistoryService.findByMember(m);
        List<ScoreHistory> histories = scoreHistoryService.findByMember(m);
        assertEquals(1, addHistories.size());
        assertEquals(1, histories.size());
    }

    @Test
    public void minusScoreTest() {
        scoreAddHistoryService.save(new Member(1l), 50, "");
        scoreAddHistoryService.save(new Member(1l), 40, "");
        scoreAddHistoryService.save(new Member(1l), 60, "");
        scoreAddHistoryService.save(new Member(1l), 20, "");
        scoreAddHistoryService.save(new Member(1l), 30, "");

//        service.minusScore(new Member(1l), 40, "", ScoreHistoryEnum.ADMIN,"");
        List<ScoreAddHistory> list1 = scoreAddHistoryService.findByMember(new Member(1l));
        assertEquals(5, list1.size());
        assertEquals(10, list1.get(0).getTotal());
        assertEquals(40, list1.get(1).getTotal());
        assertEquals(60, list1.get(2).getTotal());
        assertEquals(20, list1.get(3).getTotal());
        assertEquals(30, list1.get(4).getTotal());
//        service.minusScore(new Member(1l), 50, "", ScoreHistoryEnum.ADMIN,"");
        List<ScoreAddHistory> list2 = scoreAddHistoryService.findByMember(new Member(1l));
        assertEquals(3, list2.size());
        assertEquals(60, list2.get(0).getTotal());
        assertEquals(20, list2.get(1).getTotal());
        assertEquals(30, list2.get(2).getTotal());
//        service.minusScore(new Member(1l), 40, "", ScoreHistoryEnum.ADMIN,"");
        List<ScoreAddHistory> list3 = scoreAddHistoryService.findByMember(new Member(1l));
        assertEquals(3, list3.size());
        assertEquals(20, list3.get(0).getTotal());
        assertEquals(20, list3.get(1).getTotal());
        assertEquals(30, list3.get(2).getTotal());
//        service.minusScore(new Member(1l), 20, "", ScoreHistoryEnum.ADMIN,"");
        List<ScoreAddHistory> list4 = scoreAddHistoryService.findByMember(new Member(1l));
        assertEquals(2, list4.size());
        assertEquals(20, list4.get(0).getTotal());
        assertEquals(30, list4.get(1).getTotal());
    }

    @Test
    public void minusScoreAllTest() {
        scoreAddHistoryService.save(new Member(1l), 200, "");
//        service.minusScoreAll(new Member(1l), 1000, "", ScoreHistoryEnum.ADMIN,"");
        Member m = service.findOne(1l);
        assertEquals(0, m.getScore());
    }

    @Test
    public void minusScoreAllPartialTest() {
        scoreAddHistoryService.save(new Member(1l), 50, "");
        scoreAddHistoryService.save(new Member(1l), 40, "");
        scoreAddHistoryService.save(new Member(1l), 60, "");
        scoreAddHistoryService.save(new Member(1l), 20, "");
        scoreAddHistoryService.save(new Member(1l), 30, "");

//        service.minusScoreAll(new Member(1l), 40, "", ScoreHistoryEnum.ADMIN,"");
        List<ScoreAddHistory> list1 = scoreAddHistoryService.findByMember(new Member(1l));
        assertEquals(5, list1.size());
        assertEquals(10, list1.get(0).getTotal());
        assertEquals(40, list1.get(1).getTotal());
        assertEquals(60, list1.get(2).getTotal());
        assertEquals(20, list1.get(3).getTotal());
        assertEquals(30, list1.get(4).getTotal());
//        service.minusScoreAll(new Member(1l), 50, "", ScoreHistoryEnum.ADMIN,"");
        List<ScoreAddHistory> list2 = scoreAddHistoryService.findByMember(new Member(1l));
        assertEquals(3, list2.size());
        assertEquals(60, list2.get(0).getTotal());
        assertEquals(20, list2.get(1).getTotal());
        assertEquals(30, list2.get(2).getTotal());
//        service.minusScoreAll(new Member(1l), 40, "", ScoreHistoryEnum.ADMIN,"");
        List<ScoreAddHistory> list3 = scoreAddHistoryService.findByMember(new Member(1l));
        assertEquals(3, list3.size());
        assertEquals(20, list3.get(0).getTotal());
        assertEquals(20, list3.get(1).getTotal());
        assertEquals(30, list3.get(2).getTotal());
//        service.minusScoreAll(new Member(1l), 20, "", ScoreHistoryEnum.ADMIN,"");
        List<ScoreAddHistory> list4 = scoreAddHistoryService.findByMember(new Member(1l));
        assertEquals(2, list4.size());
        assertEquals(20, list4.get(0).getTotal());
        assertEquals(30, list4.get(1).getTotal());
    }
}
