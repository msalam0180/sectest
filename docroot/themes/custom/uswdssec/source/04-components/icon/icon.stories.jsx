import parse from 'html-react-parser';

import twigTemplate from './icon.twig';
import globalData from '../../00-config/storybook.global-data.yml';
import data from './icon.yml';

// for icons to work within another component, you need to import global data 

const settings = {
  title: 'Components/Icon',
};

const Icon = args => (
  parse(twigTemplate({
    ...args,
  }))
);
Icon.args = { ...globalData, ...data };

export default settings;
export { Icon };
