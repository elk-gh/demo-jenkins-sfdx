@isTest
private class MyTest {

    @isTest
    static void myUnitTest() {
        PageReference pr=Page.MyPage;
        Test.setCurrentPage(pr);

        Test.startTest();
        MyClass mc = new MyClass();
        Test.stopTest();

        System.assertEquals(5, mc.classes.size());
    }
}
