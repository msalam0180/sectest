import parse from 'html-react-parser';

import twigTemplate from './menu--sidebar.twig';
import data from './menu--sidebar.yml';
import '../../../02-uswds/uswds.es6';

const settings = {
  title: 'Components/Menu/Sidebar Menu',
};

const SidebarMenu = args => (
  parse(twigTemplate({
    ...args,
  }))
);
SidebarMenu.args = { ...data };

export default settings;
export { SidebarMenu };
