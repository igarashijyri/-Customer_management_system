class StaffEventPresenter < ModelPresenter
  delegate :member, :description, :occurred_at, to: :object

  def table_row
    mark_up(:tr) do |m|
      unless view_context.instance_valiable_get(:@staff_member)
        m.td do
          m << link_to(member.familiy_name + member.given_name,
            [ :admin, member, :staff_events])
        end
      end
      m.td description
      m.td(:class => "date") do
        m.text orrcurred_at.strftime("%Y%m%d %H:%m:%S")
      end
    end
  end
end