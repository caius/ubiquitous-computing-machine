require "erb"

puts ERB.new(DATA.read, 0, "-<>").result(self.__send__(:binding))

__END__
version: "v1.0"
name: "Run things"
agent:
  machine:
    type: e1-standard-2
    os_image: ubuntu1804

blocks:
<% 99.times do |i| %>
  - name: "Block <%= i + 1 %>"
    dependencies: []
    task:
      jobs:
<% (i == 0 ? 51 : 50).times do |j| -%>
      - name: "Job <%= j + 1 %>"
        commands:
          - "true"
<% end -%>
<% end %>

  - name: "Finish"
    dependencies:
<% 99.times do |i| -%>
      - "Block <%= i + 1 %>"
<% end -%>
    task:
      jobs:
        - name: "Fin"
          commands:
            - "true"
