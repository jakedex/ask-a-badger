module CoursesHelper
  def view_questions(course)
    q_count = course.questions.length
    q_count > 1 ? "View Questions (#{q_count})" : "View Question"
  end
end
