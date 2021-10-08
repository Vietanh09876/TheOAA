# The OAA
Ứng dụng theo dõi, đánh giá học sinh

[Figma Design](https://www.figma.com/file/9QZqjCdTmCinKItsjsL3GY/OAA?node-id=0%3A1)

## Login Screen
![](/Screenshots/LoginScreen.png "Login Screen")

Sử dụng **tài khoản được đăng ký trước** để có dữ liệu từ Firestore:
* Email: nguyenvietanh09876@gmail.com (recommended)
* Mật khẩu: ngaodaman09
hoặc
* Email: ngaodaman09@gmail.com
* Mật khẩu: ngaodaman09 


Nếu cần đặt lại mật khẩu thì cần **điền email vào Textfield trước** rồi nhấn **Quên Mật Khẩu?**

## News Board Screen
![](/Screenshots/NewsBoardScreen.png "News Board Screen")

Mục **Bảng Tin** sẽ hiển thị những thông báo mới nhất
* Nhấn vào một thông báo để hiển thị bản được phóng to của thông báo

Nhấn vào **Tên** ở khu vực thanh avatar để đến **Personal Info Screen** và xem các thông tin cá nhân của người dùng hiện tại

## Class List Screen
 ![](/Screenshots/ClassListScreen.png "Class List Screen")

Nhấn vào **Lớp Của Tôi** để xem các thông tin lớp học của người dùng hiện tại

Nhấn vào các mục **Khối 10, 11, 12** để xem danh sách các lớp có trong khối đó. Nhấn vào một lớp để xem thông tin của lớp đó.

### Class Info
 ![](/Screenshots/ClassMainInfo.png "Class Main Info")

 ![](/Screenshots/ClassStudenList.png "Class Student List")
 Nhấn vào một học sinh để xem thông tin của học sinh đó
 
 ![](/Screenshots/ClassTeacherList.png "Class List Screen")

## Personal Info Screen
 ![](/Screenshots/EvaluationInfo.png "Evaluation Info Screen")
 * Học Lực: Được tính theo điểm số của các môn học
 * Thể Chất: Được tính theo đánh giá của bộ môn thể dục và việc tham gia các CLB thể thao hoặc sự kiện thể thao
 * Tư Duy: Được tính theo việc tham gia các hoạt động, sự kiện của trường
 * Đóng Góp Cộng Đồng: Được theo việc tham gia các hoạt động cộng đồng và CLB
 * Tổng quát được tính theo công thức:
 
 ![](/Screenshots/OverallScoreEquation.png)
 
 
 ![](/Screenshots/ScoreboardScreen.png "Scoreboard Screen")
 Hình ảnh bảng điểm của học sinh
 
 ![](/Screenshots/PersonalInfo.png "Personal Info")
 
 ![](/Screenshots/CommunicationInfo.png "Communication Info")
 
 ![](/Screenshots/AchievementInfo.png "Achievement Info")
 Nhấn vào một **Thành Tựu** để danh sách các thành tựu được bộ Giáo dục công nhận
 Nhấn vào một **Thành Tựu (Khác)** để xem toàn bộ thông tin
 Nhấn vào **dấu "+"** để yêu cầu phê duyệt một thành tựu (Khác)
 
 ![](/Screenshots/AddSubAchievement.png "Add Sub Achievement")
 
 
## Chú Ý
 ![](/Screenshots/Error.png)
 Đã vượt quá limit Firebase Storage của ngày hôm nay nên không thể tải ảnh về.
